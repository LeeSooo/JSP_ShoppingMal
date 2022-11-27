package rent;

public class ReservationBean {
	private int no;			// 상품번호
	private int reserveNo;	// 예약번호
	private int qty;		// 구매개수
	private int day;		// 대여기간
	private String rday;	// 대여시작일
	private String id;	// 구매 이용자
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getReserveNo() {
		return reserveNo;
	}
	public void setReserveNo(int reserveNo) {
		this.reserveNo = reserveNo;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public int getDay() {
		return day;
	}
	public void setDay(int day) {
		this.day = day;
	}
	public String getRday() {
		return rday;
	}
	public void setRday(String rday) {
		this.rday = rday;
	}
	public String getId() {
		return id;
	}
	public void setId(String userID) {
		this.id = userID;
	}
}
