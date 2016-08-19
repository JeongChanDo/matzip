package com.matzip.app.kyj.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.matzip.app.kyj.dao.MatzipDao;
import com.matzip.app.kyj.domain.Matzip;


@Service
public class MatzipServiceImpl implements MatzipService {

	private static final int PAGE_SIZE = 10;
	private static final int PAGE_GROUP = 10;
	
	private MatzipDao dao;
	
	@Autowired
	public void setDao(MatzipDao dao){
		this.dao=dao;
	}
	
	@Override
	public List<Matzip>  getMatzipListAll(HttpServletRequest request, Model model) {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		
		int currentPage = Integer.valueOf(pageNum);
		int startRow = currentPage * PAGE_SIZE - PAGE_SIZE;
		int matzipCount = dao.getMatzipCount();	
		
		List<Matzip> matzipList = null;
		
		if(matzipCount > 0) {
			matzipList = dao.getMatzipListAll(startRow, PAGE_SIZE);
		}
			int pageCount = 
					matzipCount / PAGE_SIZE + (matzipCount % PAGE_SIZE == 0 ? 0 : 1);
			int startPage = (currentPage / PAGE_GROUP) * PAGE_GROUP + 1
					- (currentPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0);
			int endPage = startPage + PAGE_GROUP - 1;
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}	
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("matzipCount", matzipCount);
			model.addAttribute("PAGE_GROUP", PAGE_GROUP);
		
		return matzipList;
	}
	
	@Override
	public int getMatzipCount() {
		return dao.getMatzipCount();
	}
	
	@Override
	public Matzip getMatzip(HttpServletRequest request, Model model){
		String no = request.getParameter("no");
		/*String pageNum=request.getParameter("pageNum");*/
		
		Matzip matzip = dao.getMatzip(Integer.valueOf(no), true);
		/*model.addAttribute("pageNum", pageNum);*/
		return matzip;
	}
	
	@Override
	public void insertMatzip(HttpServletRequest request, Model model) {
		int no = 0, pageNum = 0;
		
		if(request.getParameter("no") != null) {			
			no = Integer.valueOf(request.getParameter("no"));
			/*pageNum = Integer.valueOf(request.getParameter("pageNum"));*/
		}
			model.addAttribute("no", no);
			/*model.addAttribute("pageNum", pageNum);*/
		
	}
	@Override
	public void insertMatzipRs(HttpServletRequest request, Model model) {
		
		Matzip matzip = new Matzip();
			
		matzip.setNo(Integer.valueOf(request.getParameter("no")));
		matzip.setUpso_code(request.getParameter("upso_code"));
		matzip.setUpso_name(request.getParameter("upso_name"));
		matzip.setUpso_addr(request.getParameter("upso_addr"));
		matzip.setUpso_tel(request.getParameter("upso_tel"));
		matzip.setUptae_name(request.getParameter("uptae_name"));
			
		dao.insertMatzipRs(matzip);
	}
	
	@Override
	public void updateMatzip(HttpServletRequest request, Model model) {
		String no = request.getParameter("no");
		/*String pageNum = request.getParameter("pageNum");*/
		
		Matzip matzip = dao.getMatzip(Integer.valueOf(no), false);
		
		model.addAttribute("matzip", matzip);
		/*model.addAttribute("pageNum", Integer.valueOf(pageNum));*/
		
	}

	@Override
	public void updateMatzipRs(HttpServletRequest request, Model model) {
		String no = request.getParameter("no");
		/*String pageNum = request.getParameter("pageNum");*/
		
		String upso_code = request.getParameter("upso_code");
		String upso_name = request.getParameter("upso_name");
		String upso_addr = request.getParameter("upso_addr");
		String upso_tel = request.getParameter("upso_tel");
		String uptae_name = request.getParameter("uptae_name");
		
		Matzip matzip = new Matzip();
		
		matzip.setNo(Integer.valueOf(no));
		matzip.setUpso_code(upso_code);
		matzip.setUpso_name(upso_name);
		matzip.setUpso_addr(upso_addr);
		matzip.setUpso_tel(upso_tel);
		matzip.setUptae_name(uptae_name);
		
		dao.updateMatzipRs(matzip);
	}

	@Override
	public void deleteMatzip(HttpServletRequest request, Model model) {
		String no = request.getParameter("no");
		/*String pageNum = request.getParameter("pageNum");*/
		
		Matzip matzip = dao.getMatzip(Integer.valueOf(no), false);
		
		model.addAttribute("matzip", matzip);
		/*model.addAttribute("pageNum",pageNum);*/
	}

	@Override
	public void deleteMatzipRs(HttpServletRequest request, Model model) {
		String no = request.getParameter("no");
		/*String pageNum = request.getParameter("pageNum");*/
		
		dao.deleteMatzipRs(Integer.valueOf(no));
	}	
	
	@Override
	public List<Matzip> getMatzipListByKeyword(String keyword, HttpServletRequest request, Model model) {
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.valueOf(pageNum);
		int startRow = currentPage * PAGE_SIZE - PAGE_SIZE;
		int matzipCount = dao.getMatzipCount();
		
		List<Matzip> matzipList = null;
		
		if(matzipCount > 0) {
			matzipList = dao.getMatzipByKeyword(keyword, startRow, PAGE_SIZE);
		}
			int pageCount = 
					matzipCount / PAGE_SIZE + (matzipCount % PAGE_SIZE == 0 ? 0 : 1);
			int startPage = (currentPage / PAGE_GROUP) * PAGE_GROUP + 1
					- (currentPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0);
			int endPage = startPage + PAGE_GROUP - 1;
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}	
			
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("matzipCount", matzipCount);
			model.addAttribute("PAGE_GROUP", PAGE_GROUP);
		
		return matzipList;
	}
	
	@Override
	public List<Matzip> getMatzipListByKeyword2(String keyword2, HttpServletRequest request, Model model) {
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.valueOf(pageNum);
		int startRow = currentPage * PAGE_SIZE - PAGE_SIZE;
		int matzipCount = dao.getMatzipCount();
		
		List<Matzip> matzipList = null;
		
		if(matzipCount > 0) {
			matzipList = dao.getMatzipByKeyword2(keyword2, startRow, PAGE_SIZE);
		}
			int pageCount = 
					matzipCount / PAGE_SIZE + (matzipCount % PAGE_SIZE == 0 ? 0 : 1);
			int startPage = (currentPage / PAGE_GROUP) * PAGE_GROUP + 1
					- (currentPage % PAGE_GROUP == 0 ? PAGE_GROUP : 0);
			int endPage = startPage + PAGE_GROUP - 1;
			
			if(endPage > pageCount) {
				endPage = pageCount;
			}	
			
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("matzipCount", matzipCount);
			model.addAttribute("PAGE_GROUP", PAGE_GROUP);
		
		return matzipList;
	}
	
	
}
