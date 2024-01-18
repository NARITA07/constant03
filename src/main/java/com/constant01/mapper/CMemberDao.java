package com.constant01.mapper;

import java.util.List;

import com.constant01.model.CMember;



public interface CMemberDao {

	CMember select(String m_email);

	int insert(CMember member);

	CMember selectFindId(String m_tel, String m_name);

	CMember selectFindPw(String m_email);

	int delete(String m_email);

	int update(CMember member);

	CMember selectNum(String m_email);

	int updateFindPw(String m_email, String m_password);
	
	int refund(int order_no);
	
	int getMbTotal(CMember member);

	List<CMember> mbList(CMember member);

	int adminMbDelete(String m_email);

	int upadteAmount(CMember member);

	int updateAmount2(CMember member);
}