package bbs;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

// 고객센터 게시글 작성 시, DB 접근 객체 클래스 (2022-10-28 이수)
public class BbsDAO {
	private Connection conn;			// DB 접근 객체.
	private ResultSet rs;				// 정보를 담을 수 있는 객체.
	
	// BbsDAO 생성자 : 객체 생성 시 자동으로 DB연결. (2022-10-28 이수)
	public BbsDAO() {
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
	
	// 현재 시간을 가져오는 메소드 - 게시글 작성 시, 현재 서버의 시간을 넣어주는 역활. (2022-11-28 이수) 
	 public String getDate() {
        String sql = "SELECT NOW()"; // 현재시간을 나타내는 MySQL문장
        try {
        	PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getString(1);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ""; // 데이터베이스 오류
    }
	
	// 게시글 번호를 지정해주는 메소드 (2022-11-28 이수) 
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		  String sql = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";  // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
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
	
	// 게시글 작성하는 메소드 (2022-10-28 이수)
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO bbs (bbsID,  bbsTitle,  userID,  bbsDate,  bbsContent,  bbsAvailable) VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
	
	// 한 페이지당 게시글 10개씩 제공해주는 메소드 (2022-10-29 이수)
	public ArrayList<Bbs> getList(int pageNumber) {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			/* getNext = 다음에 작성될 글의 번호, 만약 2page, 15번이라면  15 - (2-1)*10 =5, 즉 2page 1, 2, 3, 4 총 4개의 글이 나타난다.
			   만약 1page, 6번이라면 6 - (1-1)*10 = 6, 즉 1page 1, 2, 3, 4 ,5 총 5개의 글이 나타난다. */
			pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
			rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs = new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getInt(6));
                list.add(bbs);
            }
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	// 만약 마지막 개시글이 10단위 라면, 다음화면 존재하지 않게 만드는 메소드 (2022-10-29 이수)
	public boolean nextPage(int pageNumber) { //페이징 처리
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
            rs = pstmt.executeQuery();
            if(rs.next()) {
            	return true;
            }
        } catch (Exception e) {
           e.printStackTrace();
        }
			return false; 
    }
	
	// 게시글 수정하는 메소드 (2022-10-29 이수)
    public int update(int bbsID, String bbsTitle, String bbsContent) {
        String SQL = "update BBS set bbsTitle=?, bbsContent=? where bbsID=?";
        try {
        	PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, bbsContent);
            pstmt.setInt(3, bbsID);
            return pstmt.executeUpdate();
 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // 데이터베이스 오류
    }
 
    // 게시글 삭제하는 메소드 (2022-10-29 이수)
    public int delete(int bbsID) {
		String SQL = "update BBS set bbsAvailable = 0 where bbsID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
    
    // 게시글을 불러오는 메소드 (2022-10-29 이수)
    public Bbs getBbs(int bbsID){
            String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; 
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, bbsID);
                rs = pstmt.executeQuery();
                if (rs.next())
                {
                    Bbs bbs = new Bbs();
                    bbs.setBbsID(rs.getInt(1));
                    bbs.setBbsTitle(rs.getString(2));
                    bbs.setUserID(rs.getString(3));
                    bbs.setBbsDate(rs.getString(4));
                    bbs.setBbsContent(rs.getString(5));
                    bbs.setBbsAvailable(rs.getInt(6));
                    return bbs;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null; 
        }
    }