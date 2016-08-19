package com.matzip.app.djc.etc;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.matzip.app.djc.domain.MemberBean;
import com.matzip.app.djc.service.MemberService;

@Service
public class RTest {

	@Autowired
	MemberService memberService;
	
	//지역별 가입자 그래프 데이터를 리턴한다
	public String result(){
		Iterator iter =	memberService.getMemberBeanList().iterator();
		ArrayList<String> address1List = new ArrayList<String>();
		while(iter.hasNext()){
			String address1 = ((MemberBean)iter.next()).getAddress1();
			
			address1List.add(address1);
		}
		
		String[] addr = (String[]) address1List.toArray(new String[address1List.size()]);
		for(int i = 0; i< addr.length;i++){
			
			StringTokenizer token = new StringTokenizer(addr[i]," ");
			//첫번째 토큰  ex 서울  대구 부산  경남  제주특별자치도 등
			addr[i] = token.nextToken();
		//	System.out.println("addr["+i+"] : " + addr[i]);
			
			
		}
		//지역 데이터만 모앗음 중복없에야하므로 set사용
		String[] city = addr;
		
		//set에 담기위해 list로 잠시변환하고
		List<String> list = Arrays.asList(city);
		Set<String> set = new HashSet<String>();
		
		//중복값을 없앴다.
		set.addAll(list);

		
		//city에서 중복값을 없엔 배열 
		String[] sortArray = set.toArray(new String[set.size()]);
		
		//서울 3  대구 1 등과 같이 지역명과 숫자를 입력하기 위한 맵 생성
		Map<String,Integer> cityCount = new HashMap<String,Integer>();
		
		//먼저 시티 카운트부터 초기화 시킨다.
		for(int i = 0; i < sortArray.length;i++){
			cityCount.put(sortArray[i], 0);
			//서울 0  대구 0 과 같은 식으로 전부 0 으로 초기화 시킨다.
		}
		
		
		
		// city에 담겨진 모든 지역 데이터를 돌려본다
		for(int i = 0; i < city.length; i++){
			//인덱스별 지역을 우선 region 변수에 담고
			//sortArray 배열에 존재하는 데이터 와 비교한다.
			String region = city[i];
			
			for(int j = 0; j < city.length;j++){
				//분류 지역을 가지고 sort 변수에 담고
				String sort = sortArray[j];
				
				
				//기준 지역과 일치한지 비교한다.
				if(sort.equals(region)){
					//만약 기준 지역과 입력한 지역이 일치하면
					
				
					int count = cityCount.get(region);
					//주소가 대구인 사람이 3명이라면  cityCount로부터 3이란 벨류를 가지고 오고
					
					cityCount.put(region, count+1);
					//count에 1을 더하여 대구라는 키값에 덮어쓴다.
					
					
					//Map에 해당 키값의 벨류에 +1이 되면 해당 반복문을 종료한다.
					break;
				}else{
					
				}
			}
			
			
		}
		
		
		
		//이 과정을 모두 마치면 cityCount에 지역과 지역 가입자 수가 나올 것임
		
		//제주특별자치도는 이름이 기니까 제주도로 이름바꿔주자
		if(cityCount.get("제주특별자치도") != null){
			int jejuCount = cityCount.get("제주특별자치도");
			
			cityCount.remove("제주특별자치도");
			cityCount.put("제주도",jejuCount);
		}
		
		
		Set mapSet = cityCount.entrySet();
		
		Iterator setIter = mapSet.iterator();
		
		String res = null;
		String content = null;
		while(setIter.hasNext()){
			
			Entry<String,Integer> entry = (Entry<String,Integer>)setIter.next();
			
			System.out.println("지역  :  " + entry.getKey() +"    회원 수 : " + entry.getValue());
			String str = "['"+entry.getKey()+"',"+entry.getValue()+"],";
			content += str;
		}
		content = content.substring(4);
		System.out.println("배열화 : " + content);
	
		return content;
		
		
		
	}
	
	
}
