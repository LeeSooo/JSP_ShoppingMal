package payment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import product.ProductListBean;
import rent.ReservationBean;

public class PaymentDAO {
	private Connection conn;			// DB 접근 객체.
	private ResultSet rs;				// 정보를 담을 수 있는 객체.
	
	// PaymentDAO 생성자 : 객체 생성 시 자동으로 DB연결. (2022-12-10 이수)
	public PaymentDAO() {
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
	
	// 구매내역 주문번호를 지정해주는 메소드 (2022-12-10 이수) 
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		  String sql = "SELECT no FROM payment ORDER BY no DESC";  // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
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
	
	// 구매내역을 작성해주는 메소드 (2022-12-10 이수) 
	public int setPayment(String id, String address, String product, String totalPrice) {
		String SQL = "INSERT INTO payment(no,  id,  date,  address,  product,  price) VALUES(?,?,?,?,?,?)";
		
		// 현재 날짜 구하기
        LocalDate now = LocalDate.now();
        // 포맷 정의
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        // 포맷 적용
        String date = now.format(formatter);
        
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, id);
            pstmt.setString(3, date);
            pstmt.setString(4, address);
            pstmt.setString(5, product);
            pstmt.setString(6, totalPrice);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
	
	public ArrayList<PaymentListBean> getPaymentList(String id) {
		ArrayList<PaymentListBean> arr = new ArrayList<>();
		PaymentListBean bean = new PaymentListBean();
		try {
			String sql = "SELECT * FROM payment WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			// 반복문을 이용해서 검색된 정보 가져오기.
			while(rs.next()) {
				bean = new PaymentListBean(); // 왜 리셋했는지 기억은 안나는데.... 고칠 시간 없음
				bean.setNo(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setDate(rs.getString(3));
				bean.setAddress(rs.getString(4));
				bean.setProduct(rs.getString(5));
				bean.setPrice(rs.getString(6));
				arr.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
}
