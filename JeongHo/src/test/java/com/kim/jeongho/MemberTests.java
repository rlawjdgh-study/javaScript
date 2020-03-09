package com.kim.jeongho;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kim.jeongho.board.mapper.BoardMapper;
import com.kim.jeongho.cmm.domain.Criteria;
import com.kim.jeongho.cmm.domain.MemberVO;
import com.kim.jeongho.cmm.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
				"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberTests {
	
	@Setter(onMethod_ = {@Autowired})
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = {@Autowired})
	private DataSource ds;
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper boardMapper;
	
	//@Test
	public void testInsertMember() {
		
		String sql = "insert into tbl_member(userid, userpw, username) values (?, ?, ?)";
		
		for(int i = 0; i < 2; i++) {
			 
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(2, pwencoder.encode("1"));
				
				if(i == 0) {
					pstmt.setString(1, "rlawjdgh");
					pstmt.setString(3, "user");
				} else if(i == 1) {
					pstmt.setString(1, "admin");
					pstmt.setString(3, "admin");
				}
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						// TODO: handle exception
					}
				}
				
				if(con != null) {
					try {
						con.close();
					} catch (Exception e) {
						// TODO: handle exception
					}
				}
			}
		}  
	}
	
	
	
	//@Test
	public void testInsertAuth() {
		
		String sql = "insert into tbl_member_auth(userid, auth) values(?, ?)";
		
		for(int i = 0; i < 2; i++) {
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(2, pwencoder.encode("1"));
				
				if(i == 0){
					pstmt.setString(1, "rlawjdgh");
					pstmt.setString(2, "ROLE_MEMBER");
				} else if(i == 1) { 
					pstmt.setString(1, "admin");
					pstmt.setString(2, "ROLE_ADMIN");
				}  
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						// TODO: handle exception
					}
				}
				
				if(con != null) {
					try {
						con.close();
					} catch (Exception e) {
						// TODO: handle exception
					}
				}
			}
		} 
	}
	
	//@Test
	public void testRead() {
		 
		MemberVO vo = mapper.read("admin");

		log.info(vo); 
		vo.getAuthList().forEach(authVO -> log.info(authVO));
	
	}
	
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		
		List<Map<String, Object>> map = boardMapper.getListWithPaging(cri);
		System.out.println(map);
	}
}
