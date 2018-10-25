package cs5513.hw;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Types;

import javax.websocket.SessionException;

import java.sql.ResultSet;
import oracle.jdbc.pool.OracleDataSource;
import java.sql.SQLException;


public class ConnectionManager {
	String jdbcUrl			= "jdbc:oracle:thin:@oracle.cs.ou.edu:1521/pdborcl.cs.ou.edu";
	Connection conn			= null;
	OracleDataSource ods	= null;
	
	
	public Connection getOracleConnection (String uid, String pwd){
		try {
			ods = new OracleDataSource();
			ods.setURL(jdbcUrl);
			ods.setUser(uid);
			ods.setPassword(pwd);
			conn = ods.getConnection();
			return conn;
		} catch (SQLException e) {
			return null;
		}
	}
	
	public ResultSet getVehicleDetails (String uid, String pwd, String type) {
		ResultSet rs1			= null;
		Statement stmt1			= null;
		Connection conn = getOracleConnection(uid, pwd);
		if( conn != null ) {
			if (type.equalsIgnoreCase("car")){
				try {
					stmt1	= conn.createStatement();
					rs1		= stmt1.executeQuery("SELECT c.lic_plt, c.mke, c.mdl, c.yr, c.num_doors, "
							+ " max( decode( rn, 1, column_value, null ) ) opt1, "
							+ " max( decode( rn, 2, column_value, null ) ) opt2, "
							+ " max( decode( rn, 3, column_value, null ) ) opt3, "
							+ " max( decode( rn, 4, column_value, null ) ) opt4, "
							+ " max( decode( rn, 5, column_value, null ) ) opt5 "
							+ " from ( select c.lic_plt, c.mke, c.mdl, c.yr, c.num_doors, t.*, "
							+ " row_number() over ( partition by lic_plt order by COLUMN_VALUE ) rn "
							+ " from gaur4004.car c, table( c.equip_opt ) t ) c "
							+ " group by c.lic_plt, c.mke, c.mdl, c.yr, c.num_doors "
							+ " order by c.lic_plt ");
					return rs1;
				} catch(SQLException e) {
					e.printStackTrace();
					return null;
				}
//				} finally {
//					try {
//						if (conn != null) {
//							conn.close();
//						}
//					} catch (SQLException e) {
//						e.printStackTrace();
//					}
//				}
			} else if (type.equalsIgnoreCase("truck")) {
				try {
					stmt1	= conn.createStatement();
					rs1		= stmt1.executeQuery("SELECT t.lic_plt, t.mke, t.mdl, t.yr, "
							+ " t.cabin_type, t.weight, "
							+ " max( decode( rn, 1, column_value, null ) ) opt1, "
							+ " max( decode( rn, 2, column_value, null ) ) opt2, "
							+ " max( decode( rn, 3, column_value, null ) ) opt3, "
							+ " max( decode( rn, 4, column_value, null ) ) opt4, "
							+ " max( decode( rn, 5, column_value, null ) ) opt5 "
							+ " FROM ( SELECT t.lic_plt, t.mke, t.mdl, t.yr, "
							+ " t.cabin_type, t.weight, tx.COLUMN_VALUE, "
							+ " ROW_NUMBER() OVER (PARTITION BY lic_plt ORDER BY COLUMN_VALUE) rn "
							+ " FROM gaur4004.trck t, TABLE(t.equip_opt) tx) t "
							+ " GROUP BY t.lic_plt, t.mke, t.mdl, t.yr, "
							+ " t.cabin_type, t.weight "
							+ " order by t.lic_plt ");
					return rs1;
				} catch(SQLException e) {
					e.printStackTrace();
					return null;
				}
//				}finally {
//					try {
//						if (conn != null) {
//							conn.close();
//						}
//					} catch (SQLException e) {
//						e.printStackTrace();
//					}
//				}
			}
		}
		return null;
	}

	public String insertVehicle(String uid, String pwd, String vehicleType, String[] vhclDet){
		String result 		= null;
		String vehicleCheck	= null;
		PreparedStatement pstmtVhcl 	= null;
		PreparedStatement pstmtSplVhcl	= null;
		
		Connection conn = getOracleConnection(uid, pwd);
		if(conn != null){
			vehicleCheck = vehicleExist(conn, vhclDet[0]);
			if(vehicleCheck.equalsIgnoreCase("no")){
				try{
					pstmtVhcl = conn.prepareStatement("INSERT INTO gaur4004.vhcl"
							+ " VALUES(?, ?, ?, ?, equip_opt_typ(?,?,?,?,?)) ");
					pstmtVhcl.setString(1, vhclDet[0]);
					pstmtVhcl.setString(2, vhclDet[1]);
					pstmtVhcl.setString(3, vhclDet[2]);
					pstmtVhcl.setInt(4, Integer.parseInt(vhclDet[3]));
					pstmtVhcl.setString(5, vhclDet[4]);
					pstmtVhcl.setString(6, vhclDet[5]);
					pstmtVhcl.setString(7, vhclDet[6]);
					pstmtVhcl.setString(8, vhclDet[7]);
					pstmtVhcl.setString(9, vhclDet[8]);
					if(vehicleType.equalsIgnoreCase("car")) {	
						pstmtSplVhcl = conn.prepareStatement("INSERT INTO gaur4004.car"
								+ " SELECT v.lic_plt, v.mke, v.mdl, v.yr, v.equip_opt, ? "
								+ " FROM gaur4004.vhcl v"
								+ " WHERE v.lic_plt = ? ");
						pstmtSplVhcl.setInt(1, Integer.parseInt(vhclDet[9]));
						pstmtSplVhcl.setString(2, vhclDet[0]);
						pstmtVhcl.executeQuery();
						pstmtSplVhcl.executeQuery();
						result = "Insertion Successful!";
					} else if (vehicleType.equalsIgnoreCase("truck")){
						pstmtSplVhcl = conn.prepareStatement("INSERT INTO gaur4004.trck"
								+ " SELECT v.lic_plt, v.mke, v.mdl, v.yr, v.equip_opt, ?, ? "
								+ " FROM gaur4004.vhcl v"
								+ " WHERE v.lic_plt = ? ");
						pstmtSplVhcl.setString(1, vhclDet[9]);
						pstmtSplVhcl.setInt(2, Integer.parseInt(vhclDet[10]));
						pstmtSplVhcl.setString(3, vhclDet[0]);
						pstmtVhcl.executeQuery();
						pstmtSplVhcl.executeQuery();
						result = "Insertion Successful!";
					}
				} catch (SQLException e) {
					result = "Insertion Failed!";
					e.printStackTrace();
				}
			} else if (vehicleCheck.equalsIgnoreCase("yes")) {
				result = "Vehicle Exists!";
			} else if (vehicleCheck.equalsIgnoreCase("error")) {
				result = "Error while processing.";
			}
		}		
		return result;
	}
	
	public String vehicleExist(Connection conn, String licPlate) {
		String exists 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		try {
			pstmt = conn.prepareStatement("SELECT lic_plt FROM gaur4004.vhcl " 
					+ " WHERE lic_plt = ?");
			pstmt.setString(1, licPlate);
			rs = pstmt.executeQuery();
			if(rs.isBeforeFirst()) {
				exists = "yes";
			} else { exists = "no"; }
		} catch (SQLException e) {
			e.printStackTrace();
			exists = "error";
		}
//		} finally {
//			try {
//				if (conn != null) {
//					conn.close();
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
		
		return exists;
	}
	
	public ResultSet getDriverDetails (String uid, String pwd) {
		ResultSet rs	= null;
		Statement stmt	= null;
		Connection conn = getOracleConnection(uid, pwd);
		String query = " SELECT dv.drvr.di_id, dv.drvr.di_nm, dv.vhcl.lic_plt, "
					+ " dv.vhcl.mke, dv.vhcl.mdl, dv.vhcl.yr "
					+ " FROM gaur4004.di_vhcl dv "
					+ " ORDER BY dv.drvr.di_id, dv.vhcl.lic_plt " ;
		if( conn != null ) {
			try {
				stmt	= conn.createStatement();
				rs		= stmt.executeQuery(query);
				return rs;
			} catch(SQLException e) {
				e.printStackTrace();
				return rs;
			}
		}
		return rs;
	}
	
	public String insertDrvngInstrctr (String uid, String pwd, String drvId, String drvNm, String licPlt) {
		String result = null;
		PreparedStatement pstmtDrv = null;
		PreparedStatement pstmtDrvVhcl = null;
		Connection conn = getOracleConnection(uid, pwd);
		String drvCheck = driverExist(conn, drvId);
		String vhclCheck = vehicleExist(conn, licPlt);
		
		if(drvCheck.equalsIgnoreCase("no")) {
			if(vhclCheck.equalsIgnoreCase("yes")) {
				String assocCheck = vhclAssocExist(conn, licPlt);
				if (assocCheck.equalsIgnoreCase("yes")) {
					result = "The vehicle is already associated with an instructor!";
				} else if (assocCheck.equalsIgnoreCase("no")) {
					try {
					pstmtDrv = conn.prepareStatement("INSERT INTO gaur4004.drv_inst "
									+ " VALUES (?, ?) ");
					pstmtDrv.setInt(1, Integer.parseInt(drvId));
					pstmtDrv.setString(2, drvNm);
					
					pstmtDrvVhcl = conn.prepareStatement("INSERT INTO gaur4004.di_vhcl "
								  + " SELECT REF(D), REF(V) "
								  + " FROM gaur4004.drv_inst D, gaur4004.vhcl V "
								  + " WHERE D.di_id = ? "
								  + " AND V.lic_plt = ? ");
					pstmtDrvVhcl.setInt(1, Integer.parseInt(drvId));
					pstmtDrvVhcl.setString(2, licPlt);
					pstmtDrv.executeQuery();
					pstmtDrvVhcl.executeQuery();
					
					result = "Insertion Successful!";
					
				} catch (SQLException e) {
					result = ("Error while insertion!");
					e.printStackTrace();
				}
				}
			} else if (vhclCheck.equalsIgnoreCase("no")) {
				result = "The vehicle doesn't exist!";
			}
		} else if (drvCheck.equalsIgnoreCase("yes")) {
			if(vhclCheck.equalsIgnoreCase("yes")) {
				String comboCheck = driverVhclComboExist(conn, drvId, licPlt);
				if (comboCheck.equalsIgnoreCase("yes")) {
					result = "The driver is already associated with this vehicle!";
				} else if (comboCheck.equalsIgnoreCase("no")) {
					String assocCheck = vhclAssocExist(conn, licPlt);
					if (assocCheck.equalsIgnoreCase("yes")) {
						result = "The vehicle is already associated with an instructor!";
					} else if (assocCheck.equalsIgnoreCase("no")) {
						try {
							pstmtDrvVhcl = conn.prepareStatement("INSERT INTO gaur4004.di_vhcl "
									  + " SELECT REF(D), REF(V) "
									  + " FROM gaur4004.drv_inst D, gaur4004.vhcl V "
									  + " WHERE D.di_id = ? "
									  + " AND V.lic_plt = ? ");
							pstmtDrvVhcl.setInt(1, Integer.parseInt(drvId));
							pstmtDrvVhcl.setString(2, licPlt);
							pstmtDrvVhcl.executeQuery();
							result = "Insertion Successful!";
						} catch (SQLException e) {
							result = "Error while insertion!";
							e.printStackTrace();
						}
					}
				}
			} else if (vhclCheck.equalsIgnoreCase("no")) {
				result = "The vehicle doesn't exist!";
			}
		}
		return result;
	}
	
	public String driverExist(Connection conn, String drvId) {
		String exists 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		try {
			pstmt = conn.prepareStatement("SELECT di_id FROM gaur4004.drv_inst " 
					+ " WHERE di_id = ?");
			pstmt.setInt(1, Integer.parseInt(drvId));
			rs = pstmt.executeQuery();
			if(rs.isBeforeFirst()) {
				exists = "yes";
			} else { exists = "no"; }
		} catch (SQLException e) {
			e.printStackTrace();
			exists = "error";
		}
//		} finally {
//			try {
//				if (conn != null) {
//					conn.close();
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
		
		return exists;
	}
	
	public String driverVhclComboExist(Connection conn, String drvId, String licPlt) {
		String exists 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		try {
			pstmt = conn.prepareStatement("select count(*) from gaur4004.di_vhcl dv "
								  + " where dv.drvr.di_id = ? "
								  + " AND dv.vhcl.lic_plt = ? ");
			pstmt.setInt(1, Integer.parseInt(drvId));
			pstmt.setString(2, licPlt);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getInt(1) > 0) {
				exists = "yes";
			} else { exists = "no"; }
		} catch (SQLException e) {
			e.printStackTrace();
			exists = "error";
		}
//		} finally {
//			try {
//				if (conn != null) {
//					conn.close();
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
		
		return exists;
	}
	
	public String vhclAssocExist(Connection conn, String licPlt) {
		String exists 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		try {
			pstmt = conn.prepareStatement("select count(*) from gaur4004.di_vhcl dv "
								  + " WHERE dv.vhcl.lic_plt = ? ");
			pstmt.setString(1, licPlt);
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getInt(1) > 0) {
				exists = "yes";
			} else { exists = "no"; }
		} catch (SQLException e) {
			e.printStackTrace();
			exists = "error";
		}
//		} finally {
//			try {
//				if (conn != null) {
//					conn.close();
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
		
		return exists;
	}
	
	public ResultSet getStudDetails (String uid, String pwd) {
		ResultSet rs	= null;
		Statement stmt	= null;
		Connection conn = getOracleConnection(uid, pwd);
		String query = " select s.stud_id, s.stud_nm, s.stud_addr.street, s.stud_addr.city "
						+ " , b.mnth, b.dt, b.yr "
						+ " , b.di_nm, b.di_id "
						+ " from gaur4004.stud s "
						+ " LEFT OUTER JOIN  ( SELECT "
						+ " se.stud.stud_nm as stud_nm, se.stud.stud_id as stud_id "
						+ " , se.sess_dt.mnth as mnth, se.sess_dt.dy as dt, se.sess_dt.yr as yr "
						+ " , se.drvr.di_nm as di_nm, se.drvr.di_id as di_id "
						+ " from gaur4004.sess se ) b "
						+ " on s.stud_nm = b.stud_nm "
						+ " order by s.stud_id";
		if( conn != null ) {
			try {
				stmt	= conn.createStatement();
				rs		= stmt.executeQuery(query);
				return rs;
			} catch(SQLException e) {
				e.printStackTrace();
				return rs;
			}
		}
		return rs;
	}
	
	public String insertStudent (String uid, String pwd, String[] studDtls) {
		String result = null;
		PreparedStatement pstmtStud = null;
		PreparedStatement pstmtStudSess = null;
		Connection conn = getOracleConnection(uid, pwd);
		boolean sessCheck = false;
		String instCheck = "no";
		String studCheck = null;
		if(!(studDtls[3] ==  null || studDtls[4] == null || studDtls[5] == null || studDtls[6] == null
				|| studDtls[3] ==  "" || studDtls[4] == "" || studDtls[5] == "" || studDtls[6] == "")){
			sessCheck = true;
			instCheck = driverExist(conn, studDtls[6]);
		} else {sessCheck = false;}
		
		studCheck = studentExist(conn, studDtls[7]);
		
		if(studCheck.equalsIgnoreCase("no")) {
				try {
					pstmtStud = conn.prepareStatement("INSERT INTO gaur4004.stud "
									+ " VALUES (?, ?, addr_typ(?, ?)) ");
					pstmtStud.setInt(1, Integer.parseInt(studDtls[7]));
					pstmtStud.setString(2, studDtls[0]);
					pstmtStud.setString(3, studDtls[1]);
					pstmtStud.setString(4, studDtls[2]);
					
					if(sessCheck){
						if(instCheck.equalsIgnoreCase("yes")){
							pstmtStudSess = conn.prepareStatement("INSERT INTO gaur4004.sess "
										  + " SELECT date_typ(?, ?, ?), REF(S), REF(D) "
										  + " FROM gaur4004.stud S, gaur4004.drv_inst D "
										  + " WHERE S.stud_id = ? "
										  + " AND D.di_id = ? ");
							pstmtStudSess.setInt(1, Integer.parseInt(studDtls[3]));
							pstmtStudSess.setInt(2, Integer.parseInt(studDtls[4]));
							pstmtStudSess.setInt(3, Integer.parseInt(studDtls[5]));
							pstmtStudSess.setInt(4, Integer.parseInt(studDtls[7]));
							pstmtStudSess.setInt(5, Integer.parseInt(studDtls[6]));
							pstmtStud.executeQuery();
							pstmtStudSess.executeQuery();
							result = "Insertion Successful!";
						} else if (instCheck.equalsIgnoreCase("no")) {
							pstmtStud.executeQuery();
							result = "Insertion Successful, instructor non existent.";
						}
					} else {
						pstmtStud.executeQuery();
						result = "Insertion Successful.";
					}
				} catch (SQLException e) {
					result = ("Error while insertion!");
					e.printStackTrace();
				}
		} else if (studCheck.equalsIgnoreCase("yes")) {
			if(sessCheck){
				if(instCheck.equalsIgnoreCase("yes")){
					try{
						pstmtStudSess = conn.prepareStatement("INSERT INTO gaur4004.sess "
							  + " SELECT date_typ(?, ?, ?), REF(S), REF(D) "
							  + " FROM gaur4004.stud S, gaur4004.drv_inst D "
							  + " WHERE S.stud_id = ? "
							  + " AND D.di_id = ? ");
						pstmtStudSess.setInt(1, Integer.parseInt(studDtls[3]));
						pstmtStudSess.setInt(2, Integer.parseInt(studDtls[4]));
						pstmtStudSess.setInt(3, Integer.parseInt(studDtls[5]));
						pstmtStudSess.setInt(4, Integer.parseInt(studDtls[7]));
						pstmtStudSess.setInt(5, Integer.parseInt(studDtls[6]));
						pstmtStudSess.executeQuery();
						result = "Insertion Successful, session added to student!";
					} catch (SQLException e) {
						result = "Error while insertion.";
						e.printStackTrace();
					}
				} else if (instCheck.equalsIgnoreCase("no")) {
					result = "Instructor non existent/Date not entered correctly.";
				}
			} else { result = "Student already exists!"; };
		}
		return result;
	}
	
	public String studentExist(Connection conn, String studId) {
		String exists 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		
		try {
			pstmt = conn.prepareStatement("SELECT COUNT(*) FROM gaur4004.stud s " 
					+ " WHERE s.stud_id = ?");
			pstmt.setInt(1, Integer.parseInt(studId));
			rs = pstmt.executeQuery();
			rs.next();
			if(rs.getInt(1) > 0) {
				exists = "yes";
			} else { exists = "no"; }
		} catch (SQLException e) {
			e.printStackTrace();
			exists = "error";
		}
//		} finally {
//			try {
//				if (conn != null) {
//					conn.close();
//				}
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
		return exists;
	}

	public ResultSet getStudByCity(String uid, String pwd, String city){
		PreparedStatement pstmt;
		ResultSet rs;
		Connection conn = getOracleConnection(uid, pwd);
		if(conn!=null){
			try {
				pstmt = conn.prepareStatement(" SELECT s.stud_id, s.stud_nm, "
												+ " s.stud_addr.street, s.stud_addr.city "
												+ " FROM gaur4004.stud s "
												+ " WHERE s.stud_addr.city LIKE ? ");
				pstmt.setString(1, "%"+city+"%");
				rs = pstmt.executeQuery();
				return rs;
			} catch(SQLException e) {
				e.printStackTrace();
				return null;
			}
		} else { return null; }
	}
	
	public ResultSet getStudByInst(String uid, String pwd, String instNm){
		PreparedStatement pstmt;
		ResultSet rs;
		Connection conn = getOracleConnection(uid, pwd);
		if(conn!=null){
			try {
				pstmt = conn.prepareStatement(" SELECT s.stud.stud_id, s.stud.stud_nm "
												+ " , s.drvr.di_id, s.drvr.di_nm "
												+ " FROM gaur4004.sess s "
												+ " WHERE s.drvr.di_nm LIKE ? ");
				pstmt.setString(1, "%"+instNm+"%");
				rs = pstmt.executeQuery();
				return rs;
			} catch(SQLException e) {
				e.printStackTrace();
				return null;
			}
		} else { return null; }
	}
	
	public ResultSet getStudByDate(String uid, String pwd, String[] date){
		PreparedStatement pstmt;
		ResultSet rs;
		Connection conn = getOracleConnection(uid, pwd);
		if(conn!=null){
			try {
				int mnth = Integer.parseInt(date[0]);
				int day = Integer.parseInt(date[1]);
				int year = Integer.parseInt(date[2]);
				pstmt = conn.prepareStatement(" SELECT s.stud.stud_id, s.stud.stud_nm, s.sess_dt.mnth, " 
												+ " s.sess_dt.dy, s.sess_dt.yr FROM gaur4004.sess s "
												+ "   WHERE s.sess_dt.mnth = ? AND s.sess_dt.dy = ? "
												+ " AND s.sess_dt.yr = ? AND s.drvr.di_id IN  "
												+ " (SELECT dv.drvr.di_id FROM gaur4004.di_vhcl dv "
												+ " WHERE dv.vhcl.lic_plt IN "
												+ " (SELECT c.lic_plt FROM gaur4004.car c "
												+ " WHERE c.mke = 'HONDA' AND c.mdl = 'CIVIC' "
												+ " AND c.num_doors = 2)) ");
				pstmt.setInt(1, mnth);
				pstmt.setInt(2, day);
				pstmt.setInt(3, year);
				rs = pstmt.executeQuery();
				return rs;
			} catch(SQLException e) {
				e.printStackTrace();
				return null;
			}
		} else { return null; }
	}
	
	public ResultSet getCarByEquipOpt(String uid, String pwd, String equipOpt){
		PreparedStatement pstmt;
		ResultSet rs;
		Connection conn = getOracleConnection(uid, pwd);
		if(conn!=null){
			try {
				pstmt = conn.prepareStatement(" SELECT c.lic_plt, c.mke, c.mdl, c.yr "
												+ " FROM gaur4004.car c, TABLE(c.equip_opt) t "
												+ " WHERE t.COLUMN_VALUE LIKE ? ");
				pstmt.setString(1, "%"+equipOpt+"%");
				rs = pstmt.executeQuery();
				return rs;
			} catch(SQLException e) {
				e.printStackTrace();
				return null;
			}
		} else { return null; }
	}
	
	public ResultSet getInstByWght(String uid, String pwd, String wght){
		PreparedStatement pstmt;
		ResultSet rs;
		Connection conn = getOracleConnection(uid, pwd);
		if(conn!=null){
			try {
				pstmt = conn.prepareStatement(" SELECT DISTINCT(d.drvr.di_id), d.drvr.di_nm FROM gaur4004.di_vhcl d "
												+ " WHERE d.vhcl.lic_plt IN " 
												+ " (SELECT t.lic_plt FROM gaur4004.trck t "
												+ " WHERE t.weight > ? ) "
												+ " order by d.drvr.di_id ");
				pstmt.setInt(1, Integer.parseInt(wght));
				rs = pstmt.executeQuery();
				return rs;
			} catch(SQLException e) {
				e.printStackTrace();
				return null;
			}
		} else { return null; }
	}
	
	public String delCars(String uid, String pwd) {
		String result = null;
		CallableStatement cstmt;
		Connection conn = getOracleConnection(uid, pwd);
		String plsql = "DECLARE "
					+ "  license_check gaur4004.car.lic_plt%TYPE; "
					+ "  CURSOR four_door_car "
					+ "  IS "
					+ "    SELECT c.lic_plt "
					+ "    FROM gaur4004.car c "
					+ "    WHERE c.num_doors = 4; "
					+ "BEGIN "
					+ "  SELECT c.lic_plt "
					+ "    INTO license_check "
					+ "    FROM gaur4004.car c "
					+ "    WHERE c.num_doors = 4 "
					+ "    AND rownum = 1; "
					+ "  IF license_check IS NOT NULL THEN "
					+ "    FOR car in four_door_car "
					+ "    LOOP "
					+ "      DELETE FROM gaur4004.car c WHERE c.lic_plt = car.lic_plt; "
					+ "      DELETE FROM gaur4004.di_vhcl d WHERE d.vhcl.lic_plt = car.lic_plt; "
					+ "      DELETE FROM gaur4004.vhcl v WHERE v.lic_plt = car.lic_plt; "
					+ "    END LOOP; "
					+ "    ? := 'Cars deleted successfully!'; "
					+ "  END IF; "
					+ "  EXCEPTION " 
					+ "  WHEN NO_DATA_FOUND THEN "
					+ "    ? := 'No cars found!'; "
					+ "END; ";
		if(conn!=null){
			try {
				String op1 = null;
				String op2 = null;
				cstmt = conn.prepareCall(plsql);
				cstmt.registerOutParameter(1, Types.VARCHAR);
				cstmt.registerOutParameter(2, Types.VARCHAR);
				cstmt.execute();
				op1 = cstmt.getString(1);
				op2 = cstmt.getString(2);
				
				if (op1 != null && op1.equalsIgnoreCase("Cars deleted successfully!")) {
					result = "Cars deleted successfully!";
				} else if (op2 != null && op2.equalsIgnoreCase("No cars found!")) {
					result = "No cars with 4 doors found.";
				}
				return result;
			} catch(SQLException e) {
				e.printStackTrace();
				return "Error while processing request!";
			}
		} else { return null; }
	}
	
}