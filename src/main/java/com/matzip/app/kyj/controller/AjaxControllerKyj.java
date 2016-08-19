package com.matzip.app.kyj.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.matzip.app.kyj.domain.Matzip;
import com.matzip.app.kyj.json.JsonSearchKeyword;
import com.matzip.app.kyj.json.JsonSearchKeywordResult;
import com.matzip.app.kyj.json.JsonSearchKeywordResultList;
import com.matzip.app.kyj.service.MatzipService;

@RequestMapping("/ajax")
@Controller

public class AjaxControllerKyj {
	@Autowired
	MatzipService service;
	
	@RequestMapping("/keywordJson.json")
	@ResponseBody
	public JsonSearchKeywordResultList searchKeyword(@RequestBody JsonSearchKeyword keyword1, HttpServletRequest request,Model model){
		
		String keyword = keyword1.getKeyword();
		List<Matzip> bList = service.getMatzipListByKeyword(keyword, request,  model);
		Iterator<Matzip> iter = bList.iterator();
		JsonSearchKeywordResult result;
		
		List<JsonSearchKeywordResult>mList = new ArrayList<JsonSearchKeywordResult>();

		while(iter.hasNext()){
			Matzip m = iter.next();
			result = new JsonSearchKeywordResult();
			result.setUpsoName(m.getUpso_name());
			result.setUpsoAddr(m.getUpso_addr());
			result.setUptaeName(m.getUptae_name());
			result.setNo(m.getNo());
			
			mList.add(result);
		}
		
		JsonSearchKeywordResultList resultList = new JsonSearchKeywordResultList(mList);
		
		return resultList;
	}
	
	@RequestMapping("/keywordJson2.json")
	@ResponseBody
	public JsonSearchKeywordResultList searchKeyword2(@RequestBody JsonSearchKeyword keyword2, HttpServletRequest request,Model model){
		
		String keyword = keyword2.getKeyword();
		List<Matzip> bList = service.getMatzipListByKeyword2(keyword, request,  model);
		Iterator<Matzip> iter = bList.iterator();
		JsonSearchKeywordResult result;
		
		List<JsonSearchKeywordResult>mList = new ArrayList<JsonSearchKeywordResult>();

		while(iter.hasNext()){
			Matzip m = iter.next();
			result = new JsonSearchKeywordResult();
			result.setUpsoName(m.getUpso_name());
			result.setUpsoAddr(m.getUpso_addr());
			result.setUptaeName(m.getUptae_name());
			result.setNo(m.getNo());
			
			mList.add(result);
		}
		
		JsonSearchKeywordResultList resultList = new JsonSearchKeywordResultList(mList);
		
		return resultList;
	}
}
