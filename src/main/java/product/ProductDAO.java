package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import org.apache.commons.dbcp2.PStmtKey;

public class ProductDAO {
	private Connection conn;			// DB 접근 객체.
	private ResultSet rs;				// 정보를 담을 수 있는 객체.
	
	// ProductDAO 생성자 : 객체 생성 시 자동으로 DB연결. (2022-11-26 이수)
	public ProductDAO() {
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
	
	// 메인화면에서 최신순으로 3개의 제품을 리턴하는 메소드
	public ArrayList<ProductListBean> getSelecter(){
		ArrayList<ProductListBean> arr = new ArrayList<>();
		
		try {
			// 최신순으로 제품 가져오기.
			//"SELECT userPassword FROM USER WHERE userID = ?";
			String sql = "SELECT * FROM product ORDER BY no DESC";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int cnt = 0;
			while(rs.next()) {
				ProductListBean bean = new ProductListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setInfo(rs.getString(4));
				bean.setImg(rs.getString(5));
				arr.add(bean);
				cnt++;
				if(cnt >= 3) break;	// 제품 3개만 리스트에 저장.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
}
