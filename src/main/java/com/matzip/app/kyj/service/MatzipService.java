package com.matzip.app.kyj.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.matzip.app.kyj.domain.Matzip;


public interface MatzipService {
	
	public List<Matzip> getMatzipListAll(HttpServletRequest request, Model model);
	
	public int getMatzipCount();
	
	public Matzip getMatzip(HttpServletRequest request, Model model);
	
	public void insertMatzip(HttpServletRequest request,Model model); 
	
	public void insertMatzipRs(HttpServletRequest request,Model model);
	
	public void updateMatzip(HttpServletRequest request,Model model);
	
	public void updateMatzipRs(HttpServletRequest request,Model model);
	
	public void deleteMatzip(HttpServletRequest request,Model model);
	
	public void deleteMatzipRs(HttpServletRequest request,Model model);
	
	public List<Matzip> getMatzipListByKeyword(String keyword, HttpServletRequest request, Model model);
	
	public List<Matzip> getMatzipListByKeyword2(String keyword2, HttpServletRequest request, Model model);
	
}
