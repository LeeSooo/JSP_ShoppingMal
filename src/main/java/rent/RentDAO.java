package rent;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rent.ReservationBean;

public class RentDAO {
	private Connection conn;			// DB 접근 객체.
	private ResultSet rs;				// 정보를 담을 수 있는 객체.
	
	// RentDAO 생성자 : 객체 생성 시 자동으로 DB연결. (2022-11-26 이수)
	public RentDAO() {
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
	
	// 예약번호를 지정해주는 메소드 (2022-11-28 이수) 
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		  String sql = "SELECT reserveno FROM reserve ORDER BY reserveno DESC";  // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	return rs.getInt(1) + 1; // 그 다음 게시글의 번호
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 하나의 예약 정보를 저장하는 메소드
	public int setReserve(int no, String id, int qty, int day, String rday) {
		try {
			String sql = "Insert Into reserve values(?,?,?,?,?,?);";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, no);		// 상품번호
			pstmt.setString(3, id);		// 회원아이디
			pstmt.setInt(4, qty);		// 상품개수
			pstmt.setInt(5, day);		// 대여일
			pstmt.setString(6, rday);	// 대여시작일
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;			// DB 오류.
	}
	
	// 모든예약 정보를 보여주는 메소드
	public ArrayList<ReservationBean> getAllReserve(String id) {
		ArrayList<ReservationBean> arr = new ArrayList<>();
		// 데이터를 저장할 객체선언
		ReservationBean bean = null;
		try {
			String sql = "SELECT * FROM reserve WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 반복문을 이용해서 검색된 제품 가져오기.
			while(rs.next()) {
				bean = new ReservationBean();
				bean.setNo(rs.getInt("no"));
				bean.setReserveNo(rs.getInt("reserveno"));
				bean.setId(rs.getString("id"));
				bean.setDay(rs.getInt("day"));
				bean.setRday(rs.getString("rday"));
				bean.setQty(rs.getInt("qty"));
				arr.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
}
