package com.kh.common;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {
	
	// 모든 메소드 static
	
	// 1. Connection 객체 생성 한후 해당 생성된 Connection반환해주는 getConnection 메소드
	public static Connection getConnection() {
		
		Connection conn = null;
		
		Properties prop = new Properties();	// Map 계열 컬렉션(key-value 세트로 보관)
		
		// 읽어들이고자 하는 driver.properties(classes폴더 안에) 파일의 물리적 경로
		String fileName = JDBCTemplate.class.getResource("/sql/driver/driver.properties").getPath();
		// C:\\servlet-jsp-workspace2\\jspProject\webContent\WEB-INF\classess~~
		
		
		
		
		try {
			prop.load(new FileInputStream(fileName));
			// driver.properties에 기록된 키 밸류 세트들이 prop에 다 담겨있음!
			
			// 1) Oracle Driver class 등록 (jdbc drive 등록)
			/* Class.forName("oracle.jdbc.driver.OracleDriver"); */
			Class.forName(prop.getProperty("driver"));
			
			// 2) Connection 객체 생성(DB와 접속)
			//conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","SERVER","SERVER");
			conn = DriverManager.getConnection(prop.getProperty("url"),
											   prop.getProperty("username"),
											   prop.getProperty("password"));
		
				//ojdbc6.jar 외부라이브러리 WebContent/WEB-INF/lib 안에 추가
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			
			e.printStackTrace();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
		return conn;
	}
	
	
	// 2. Connection 객체 전달 받아서 commit해주는 commit메소드
	public static void commit(Connection conn) {
		
		try {
			if(conn != null && !conn.isClosed()) {
				conn.commit();
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
	}
	// 3. Connection 객체 전달 받아서 rollback해주는 rollback메소드
	public static void rollback(Connection conn) {
		
		try {
			if(conn != null && ! conn.isClosed()) {
				conn.rollback();
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	// 4. Connection 객체 전달 받아서 close해주는 close메소드 
	public static void close(Connection conn) {
		try {
			if(conn !=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	// 5.Statement관련 객체 전달 받아서 close해주는 close메소드
	public static void close(Statement stmt) {
		
		try {
			if(stmt != null && !stmt.isClosed()) {
				stmt.close();
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	// 6. ResultSet객체 전달 받아서 close해주는  close메소드
	public static void close(ResultSet rset) {
		try {
			if(rset != null && !rset.isClosed()) {
				rset.close();
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
}
