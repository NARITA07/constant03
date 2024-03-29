package com.constant01.mapper;

import java.util.ArrayList;

import com.constant01.model.BoardDTO;
import com.constant01.model.CMember;
import com.constant01.model.Criteria;
import com.constant01.model.QnA;
import com.constant01.model.QnAr;
import com.constant01.model.cartVO;

public interface ReleaseMapper {

	public BoardDTO boarddetail(BoardDTO detail);
	public ArrayList<BoardDTO> boardpage(Criteria cri);
	public ArrayList<BoardDTO> boardpage2(Criteria cri);
	public ArrayList<BoardDTO> boardpage3(Criteria cri);
	public ArrayList<BoardDTO> boardpage4(Criteria cri);
	public ArrayList<BoardDTO> boardpage5(Criteria cri);
	
	
	public int getTotal();
	public int getTotal2();
	public int getTotal3();
	public int getTotal4();
	public int getTotal5();
	
	//주문현황
	public ArrayList<cartVO> orderlist(Criteria cri);
	public int getTotal_order();
	
	
	//qna
	public ArrayList<QnA> qna(Criteria cri);
	public int getTotal_qna(Criteria cri);
	public void qna_write(QnA qna);
	public ArrayList<QnA> WriteDetail(QnA qna);
	public ArrayList<QnAr> detail_answer(QnAr qnar);
	public ArrayList<CMember> member_detail(CMember member);
	public void changePassword(CMember member);
	public void qna_delete(QnA qna);
	
}
