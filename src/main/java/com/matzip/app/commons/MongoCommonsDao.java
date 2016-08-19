package com.matzip.app.commons;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.bson.BsonDocument;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

import com.matzip.app.djc.domain.LogBean;
import com.matzip.app.djc.domain.MemberBean;
import com.mongodb.Block;
import com.mongodb.DBCollection;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;


@Repository
public class MongoCommonsDao {

	@Autowired
	MongoTemplate mongoTemplate;
	//dbName MatZip 
	
	@Autowired
	MongoClient mongoClient;
	
	public DBCollection getLogCollection(){
		return mongoTemplate.getCollection("requestLog");
	}
	
	public MongoCollection<Document> getLogCol(){
		return mongoClient.getDatabase("MatZip").getCollection("log");
	}
	

	public void adminPageNo1RequestProcess(HttpServletRequest request){
		
		String monthlyRequestDay = "[";
		String monthlyRequestMoment = "[";
		
		LocalDate today = LocalDate.now();
		int year = today.getYear();
		int month = today.getMonth().getValue();
		int day = today.getDayOfMonth();
		System.out.println("오늘은  " +year+" " + month+" "+ day +" 일 입니다.");
		int count = 0;
		int beforeCount = 0;
		for(int i = 1 ; i<= day ; i++){
			
	
		//	Bson bson = BsonDocument.parse("{time:{$lt:new Date(new Date().setDate(new Date().getDate()-("+i+"-1))), $gte: new Date(new Date().setDate(new Date().getDate())-"+i+"))}}");
			
			
			Bson bson = BsonDocument.parse("{time:{ $gte:new Date("+year+","+(month-1)+",1), $lt: new Date("+year+","+(month-1)+","+i+")} }");
			
			count = (int) getLogCol().count(bson);
			
			count = count - beforeCount;
			//19일동안 데이터 18일 동안데이터
			
			System.out.println(i +"   : " +count);
			
			
			if(i == day){
				monthlyRequestDay += i+"]";
				monthlyRequestMoment += count +"]";
				break;
			}
			monthlyRequestDay += i+",";
			monthlyRequestMoment += count +",";
		}
	
		System.out.println("monthlyRequestDay : " + monthlyRequestDay);
		System.out.println("monthlyRequestMoment : " + monthlyRequestMoment);
		
		beforeCount = count;
		// 18일 18일
		request.setAttribute("monthlyRequestDay", monthlyRequestDay);
		request.setAttribute("monthlyRequestMoment", monthlyRequestMoment);
	}
	
	
	public void insertRequestLog(HttpServletRequest request){
		String host = request.getRemoteHost();
		String uri = request.getRequestURI().substring(request.getContextPath().length());
		HttpSession session = request.getSession();
		Timestamp time = new Timestamp(System.currentTimeMillis());

		System.out.println("\n-----------\n");
		
		System.out.println("RequestInterceptor\n");
		System.out.println("time : "+time);
		System.out.println("host : " + host);
		String request1 = null;
		
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,String> paramMap = new HashMap<String,String>();

		if(request.getQueryString() != null){
			System.out.println("파라미터가 존재합니다.");
			request1 = uri+"?"+request.getQueryString();
			
			map.put("request", request1);

			String queryString = request.getQueryString();
			StringTokenizer token = new StringTokenizer(queryString,"&");
			
			while(token.hasMoreTokens()){
				String parameterToken = token.nextToken();
				String[] parameter = parameterToken.split("=");
				
				System.out.println("parameter[0] : " + parameter[0] +"    parameter[1] : " + parameter[1]);
				
				paramMap.put(parameter[0],parameter[1]);
				
			}
			map.put("parameters", paramMap);
			
			
		}
		System.out.println("uri : " + uri);

		
		String id = null;
		if(session.getAttribute("loginedMember")!= null){
			id = ((MemberBean)session.getAttribute("loginedMember")).getId();
			System.out.println("로그인 되어 있습니다.");
		}else{
			System.out.println("로그인 상태가 아닙니다.");

		}

		map.put("time",time);
		map.put("uri", uri);
		map.put("ip", host);

		
		
		if(id != null){
			System.out.println("id : " + id);
			map.put("id", id);
		}
		System.out.println("\n-----------\n");

		Document doc = new Document(map);

		
		getLogCol().insertOne(doc);
		
	}
	

	public List<LogBean> getLogAboutId(String id){
		List<LogBean> lList = new ArrayList<LogBean>();
		Bson bson = BsonDocument.parse("{id:'"+id+"'}");
		Bson bson2 = BsonDocument.parse("{time:-1}");
		FindIterable<Document> iter = getLogCol().find(bson).sort(bson2);
		System.out.println("첫 번째 결과 url : "+iter.first().toJson());
		iter.forEach(new Block<Document>(){
			LogBean log;

			@Override
			public void apply(Document doc) {
				log = new LogBean();
				log.setTime(doc.getDate("time"));
				log.setUri(doc.getString("uri"));
				log.setRequest(doc.getString("request"));
				log.setIp(doc.getString("ip"));
				log.setId(doc.getString("id"));
				lList.add(log);
			}
			
		});
		
		return lList;
	}
	public List<LogBean> getThirtySearchedLogs(String keyword,int number, int i){
		int skipNum = (i-1) *30;

		List<LogBean> logList = new ArrayList<LogBean>();
		//1이면 요청
		//2이면 id
		Bson bson = BsonDocument.parse("{request:{$regex:'.*"+keyword+".*'}}");
		if(number == 2){
			bson = BsonDocument.parse("{id:{$regex:'.*"+keyword+".*'}}");
		}
		
		Bson bson2 = BsonDocument.parse("{time:-1}");
		FindIterable<Document> iter = getLogCol().find(bson).sort(bson2).skip(skipNum).limit(30);

		iter.forEach(new Block<Document>(){
			LogBean log;
			@Override
			public void apply(Document doc) {
				Map<String,String> parameters = null;

				log = new LogBean();
				log.setTime(doc.getDate("time"));
				log.setUri(doc.getString("uri"));
				log.setRequest(doc.getString("request"));
				log.setIp(doc.getString("ip"));
				log.setId(doc.getString("id"));
				//파라미터가 있으면 담기위한 조건문
				if(doc.get("parameters") != null){
					System.out.println("파라미터가 존재합니다.");
					//parameters란 키가 존재하면
					
					parameters = (Map<String,String>)doc.get("parameters");
					System.out.println("paramters의 사이즈 : " + parameters.size());
					
					log.setParameters(parameters);
				}
				logList.add(log);
			}

		});
		return logList;
	}
	
	
	public List<LogBean> getThirtyLogs(int i){
		int skipNum = (i-1) *30;
		
		List<LogBean> lList = new ArrayList<LogBean>();
		Bson bson2 = BsonDocument.parse("{time:-1}");
		FindIterable<Document> iter = getLogCol().find().sort(bson2).skip(skipNum).limit(30);
		System.out.println("첫 번째 결과 url : "+iter.first().toJson());
	
		iter.forEach(new Block<Document>(){
			LogBean log;

			@Override
			public void apply(Document doc) {
				Map<String,String> parameters = null;

				log = new LogBean();
				log.setTime(doc.getDate("time"));
				log.setUri(doc.getString("uri"));
				log.setRequest(doc.getString("request"));
				log.setIp(doc.getString("ip"));
				log.setId(doc.getString("id"));
				//파라미터가 있으면 담기위한 조건문
				if(doc.get("parameters") != null){
					System.out.println("파라미터가 존재합니다.");
					//parameters란 키가 존재하면
					
					parameters = (Map<String,String>)doc.get("parameters");
					System.out.println("paramters의 사이즈 : " + parameters.size());
					
					log.setParameters(parameters);
				}
				lList.add(log);
			}
			
		});
		
		return lList;
	}
	
	
}
