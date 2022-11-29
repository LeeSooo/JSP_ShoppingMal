package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import rent.ReservationBean;

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
			String sql = "SELECT * FROM product ORDER BY no DESC";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int cnt = 0;
			while(rs.next()) {
				ProductListBean bean = new ProductListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setRentalprice(rs.getInt(4));
				bean.setCategory(rs.getString(5));
				bean.setInfo(rs.getString(6));
				bean.setImg(rs.getString(7));
				arr.add(bean);
				cnt++;
				if(cnt >= 3) break;	// 제품 3개만 리스트에 저장.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	
	// 상품 검색하는 메소드
	public ArrayList<ProductListBean> getSearch(String search){
		ArrayList<ProductListBean> arr = new ArrayList<>();
		
		// 데이터를 저장할 객체선언
		ProductListBean bean = null;
		if(search.equals("")) {
			try {
				// 검색된 내용이 없으면 전체 상품을 가져오기.
				String sql = "SELECT * FROM product";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				// 반복문을 이용해서 검색된 제품 가져오기.
				while(rs.next()) {
					bean = new ProductListBean();
					bean.setNo(rs.getInt(1));
					bean.setName(rs.getString(2));
					bean.setPrice(rs.getInt(3));
					bean.setRentalprice(rs.getInt(4));
					bean.setCategory(rs.getString(5));
					bean.setInfo(rs.getString(6));
					bean.setImg(rs.getString(7));
					arr.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else {
			try {
				// 검색된 제품 가져오기.
				String sql = "SELECT * FROM product WHERE name = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, search);
				rs = pstmt.executeQuery();
				
				// 반복문을 이용해서 검색된 제품 가져오기.
				while(rs.next()) {
					bean = new ProductListBean();
					bean.setNo(rs.getInt(1));
					bean.setName(rs.getString(2));
					bean.setPrice(rs.getInt(3));
					bean.setRentalprice(rs.getInt(4));
					bean.setCategory(rs.getString(5));
					bean.setInfo(rs.getString(6));
					bean.setImg(rs.getString(7));
					arr.add(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return arr;
	}
	
	// 모든 상품을 보여주는 메소드
	public ArrayList<ProductListBean> getAllProduct(){
		ArrayList<ProductListBean> arr = new ArrayList<>();
		
		// 데이터를 저장할 객체선언
		ProductListBean bean = null;
		try {
			String sql = "SELECT * FROM product";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 반복문을 이용해서 검색된 제품 가져오기.
			while(rs.next()) {
				bean = new ProductListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setRentalprice(rs.getInt(4));
				bean.setCategory(rs.getString(5));
				bean.setInfo(rs.getString(6));
				bean.setImg(rs.getString(7));
				arr.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
	
	// 상품 상세정보를 보여주는 메소드
	public ProductListBean getProductInfo(int no){
		// 데이터를 저장할 객체선언
		ProductListBean bean = new ProductListBean();
		try {
			String sql = "SELECT * FROM product WHERE no = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			
			// 반복문을 이용해서 검색된 제품 가져오기.
			if(rs.next()) {
				bean = new ProductListBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setRentalprice(rs.getInt(4));
				bean.setCategory(rs.getString(5));
				bean.setInfo(rs.getString(6));
				bean.setImg(rs.getString(7));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
}
