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
	public void setReserve(ReservationBean bean) {
		try {
			String sql = "Insert Into reserve(reserveno, no, id, qty, day, rday) "
					+ "values(?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, bean.getNo());		// 상품번호
			pstmt.setString(3, bean.getId());	// 회원아이디
			pstmt.setInt(4, bean.getQty());		// 상품개수
			pstmt.setInt(5, bean.getDay());		// 대여일
			pstmt.setString(6, bean.getRday());	// 대여시작일
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	// 모든예약 정보를 보여주는 메소드
	public ArrayList<ReservationBean> getAllReserve(String id) {
		ArrayList<ReservationBean> arr = new ArrayList<>();
		// 데이터를 저장할 객체선언
		ReservationBean bean = new ReservationBean();
		
		try {
			String sql = "SELECT reserveno FROM reserve WHERE id=? "
					+ "values(?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			// 반복문을 이용해서 검색된 제품 가져오기.
			while(rs.next()) {
				bean = new ReservationBean();
				bean.setNo(rs.getInt(1));
				bean.setReserveNo(rs.getInt(2));
				bean.setQty(rs.getInt(3));
				bean.setDay(rs.getInt(4));
				bean.setRday(rs.getString(5));
				bean.setId(rs.getString(6));
				arr.add(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return arr;
	}
}
