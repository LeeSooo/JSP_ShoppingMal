package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import encryption.SHA256;
import product.ProductListBean;

// DB 접근 객체 클래스 - 회원 정보를 불러오고, 추가하는 기능 수행. (2022-11-28 이수)
public class UserDAO {
	private Connection conn;			// DB 접근 객체.
	private PreparedStatement pstmt;	// SQL 인젝션 해킹기법 방어수단(pstmt)객체.
	private ResultSet rs;				// 정보를 담을 수 있는 객체.
	
	// UserDAO 생성자 : 객체 생성 시 자동으로 DB연결. (2022-11-28 이수)
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/SHOP?useUnicode=true&serverTimezone=UTC";	// DB 접속 주소.
			String dbID = "root";									
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");				// 드라이버를 통해 mySQL에 접속할 수 있는 매개체 역활을 수행함.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인을 시도하는 메소드 (2022-11-28 이수)
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM USER WHERE userID = ?";
		SHA256 sha256 = new SHA256();
		
		// DB 검색 수행
		try {
			pstmt = conn.prepareStatement(sql);		// SQL 문장 수행 - SQL 인젝션 해킹기법 방어수단.(pstmt)
			pstmt.setString(1, userID);				// ?에 userID 삽입.
			rs = pstmt.executeQuery();				// SQL 문장 실행 결과 저장.
			
			if(rs.next()) {
				if(rs.getString(1).equals(sha256.encrypt(userPassword)))
					return 1; 	// 로그인 성공.
				else
					return 0; 	// 비밀번호 불일치.
			}
			return -1; 	
			// 아이디 없음.
			
		} catch (Exception e) {
			return -2;			// DB 오류.
		}
	}
	
	// 회원가입을 시도하는 메소드 (2022-11-28 이수)
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
		SHA256 sha256 = new SHA256();	// 암호화 객체
		
		// DB 입력 수행
		try {
			pstmt = conn.prepareStatement(SQL);								// SQL 문장 수행 - SQL 인젝션 해킹기법 방어수단.(pstmt)
			pstmt.setString(1, user.getUserID());							// ?에 userID 삽입.
			pstmt.setString(2, sha256.encrypt(user.getUserPassword()));		// ?에 UserPassword 삽입.
			pstmt.setString(3, user.getUserName());							// ?에 UserName 삽입.
			pstmt.setString(4, user.getUserEmail());						// ?에 UserEmail 삽입.
			pstmt.setString(5, user.getUserPhone());						// ?에 UserPhone 삽입.
			pstmt.setString(6, user.getUserAddress());						// ?에 UserAddress 삽입.
			pstmt.setString(7, user.getUserPostcode());						// ?에 UserPostcode 삽입.
			pstmt.setString(8, user.getUserGender());						// ?에 UserGender 삽입.
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;			// DB 오류.
		
	}
	
	// 마이페이지 보여주는 메소드 (2022-12-10)
	public User getUser(String id) {
		User bean = new User();
		try {
			String sql = "SELECT * FROM user WHERE userID = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new User();
				bean.setUserID(rs.getString(1));
				bean.setUserPassword(rs.getString(2));
				bean.setUserName(rs.getString(3));
				bean.setUserEmail(rs.getString(4));
				bean.setUserPhone(rs.getString(5));
				bean.setUserAddress(rs.getString(6));
				bean.setUserPostcode(rs.getString(7));
				bean.setUserGender(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	// 비밀번호 재설정 검색 메소드(2022-12-11 이수)
	public int getSearch(String id, String name, String email, String phone) {
		User bean = new User();
		try {
			String sql = "SELECT * FROM user WHERE userID = ? and userName = ? and userEmail = ? and userPhone = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, phone);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 검색 성공 시
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 검색 실패 시
		return -1;
	}
	
	// 비밀번호 재설정하는 메소드(2022-12-11 이수)
	public int getResetPassword(String id, String pw) {
		SHA256 sha256 = new SHA256();
		try {
			String sql = "UPDATE user SET userPassword = ? WHERE userID = ?;";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sha256.encrypt(pw));
			pstmt.setString(2, id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

}
