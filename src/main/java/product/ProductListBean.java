package product;

//상품정보 DB 정보 클래스 (2022-11-26 이수)
public class ProductListBean {
	private int no;
	private String name;
	private int price;
	private int rentalprice;
	private String category;
	private String info;
	private String img;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getRentalprice() {
		return rentalprice;
	}
	public void setRentalprice(int rentalprice) {
		this.rentalprice = rentalprice;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
}
