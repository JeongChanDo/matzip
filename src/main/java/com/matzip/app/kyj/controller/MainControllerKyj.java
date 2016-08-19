package com.matzip.app.kyj.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.matzip.app.kyj.domain.Matzip;
import com.matzip.app.kyj.service.MatzipService;

@Controller
public class MainControllerKyj {

	String redirectIndex = "redirect:index";
	
	@Autowired
	MatzipService service;
	
	@RequestMapping("/areaSearch")
	public String areaSearch(HttpServletRequest request,Model model){
		List<Matzip> matzipList = service.getMatzipListAll(request,model);
		model.addAttribute("matzipList", matzipList);
		return "areaSearch";
	}
	
	@RequestMapping("/mcontent")
	public String mcontent(HttpServletRequest request,Model model){
		Matzip matzip = service.getMatzip(request, model);
		model.addAttribute("matzip", matzip);
		return "matzip/mcontent";
	}
	
	@RequestMapping("/mwriteForm")
	public String mwriteForm(HttpServletRequest request,Model model){
		service.insertMatzip(request, model);
		return "matzip/mwriteForm";
	}
	
	@RequestMapping("/mwrite")
	public String mwrite(HttpServletRequest request,Model model){
		service.insertMatzipRs(request, model);
		return "redirect:/areaSearch";
	}
	
	@RequestMapping("/mupdateForm")
	public String mupdate(HttpServletRequest request,Model model){
		service.updateMatzip(request,model);
		return "matzip/mupdateForm";
	}
	
	@RequestMapping("/mupdate")
	public String mupdateRs(HttpServletRequest request,Model model){
		service.updateMatzipRs(request, model);
		return "redirect:/areaSearch";
	}
	
	@RequestMapping("/mdeleteForm")
	public String mdeleteForm(HttpServletRequest request,Model model){
		service.deleteMatzip(request,model);
		return "matzip/mdeleteForm";
	}
	
	@RequestMapping("/mdelete")
	public String mdelete(HttpServletRequest request,Model model){
		service.deleteMatzipRs(request,model);
		return "redirect:/areaSearch";
	}		
	
}
