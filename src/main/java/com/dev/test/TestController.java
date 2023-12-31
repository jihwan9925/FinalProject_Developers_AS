package com.dev.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
@Transactional
public class TestController {

	private TestService service;

	public TestController(TestService service) {
		this.service = service;
	}

	@GetMapping("/insert")
		public void InsertTest() throws IOException {
//			String host="14.36.141.71";
//			int port=8877;
//
//			Socket socket = new Socket(); 
//			SocketAddress socketAddress = new InetSocketAddress(host, port); 
//			socket.connect(socketAddress, 30000);
//			socket.setSoTimeout(30000);
//			
//			ServerSocket serverSocket = new ServerSocket(port);
//			serverSocket.setSoTimeout(40000);
			
//			12337
//			서울, 인천, 대전,  대구, 광주,  부산,  울산, 세종특별자치시, 경기도, 강원특별자치도,충청북도, 충청남도,
//			경상북도, 경상남도, 전라북도, 전라남도, 제주도,
//			 2, 3, 4, 5, 6, 7, 8, 31, 32, 33, 34, 35, 36, 37, 38, 39 
//			먼저 콘텐트 ID api의 pk값을 가져오기 위한 처음 요청보낼 api주소
			int[] areaCode = {1};
			for (int i : areaCode) {

				StringBuilder result = new StringBuilder();

				String urlStr = "http://apis.data.go.kr/B551011/KorService1/areaBasedList1?"
						+ URLEncoder.encode("serviceKey", "UTF-8") + "="
						+ URLEncoder.encode(
								"0906O7Vl32hAkLceKylOGOAzJuIESMtXTXESfLV++obF/XFUtduY0IZn4KnJnwSMB3L5HTj7oRuH8PqFhVAQ6w==",
								"UTF-8")
						+ "&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8") + "&"
						+ URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("12027", "UTF-8") + "&"
						+ URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8") + "&"
				//		+ URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(i), "UTF-8") + "&"
						+ URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8") + "&"
						+ URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8") + "&"
						+ URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8");
				URL url = new URL(urlStr);

				HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
				urlConnection.setConnectTimeout(60000);
				urlConnection.setReadTimeout(60000);
				urlConnection.setRequestMethod("GET");

				BufferedReader br = new BufferedReader(
						new InputStreamReader(urlConnection.getInputStream(), Charset.forName("UTF-8")));

				String returnLine;

				while ((returnLine = br.readLine()) != null) {
					result.append(returnLine + "\n\r");
				}
				urlConnection.disconnect();
//			System.out.println(result.toString());

//			여기서 부터 파싱 코드
//			파싱 객체 생성 
//			파싱할 객체 생성
//				JsonParser paraser = new JsonParser();
//				JsonObject obj = paraser.parse(result.toString()).getAsJsonObject();
				JsonObject obj=JsonParser.parseString(result.toString()).getAsJsonObject();
				
				JsonArray arr = obj.get("response").getAsJsonObject().get("body").getAsJsonObject().get("items")
						.getAsJsonObject().get("item").getAsJsonArray();
				for (JsonElement jsonElement : arr) {
					JsonObject temp = jsonElement.getAsJsonObject();
				System.out.println("===============================");
				System.out.println("관광지 ID(콘텐트ID) : " + temp.get("contentid"));
				System.out.println(temp.get("title"));
				System.out.println(temp.get("addr1"));
				System.out.println(temp.get("mapy"));
				System.out.println(temp.get("mapx"));
				System.out.println(temp.get("mlevel"));
				System.out.println(temp.get("firstimage"));
				System.out.println(temp.get("tel"));
				System.out.println(temp.get("areacode"));
				}
				//list.add(temp.get("contentid").getAsString());
//				for()
//				Test test=Test.builder()
//						.tourisId(temp.get("contentid").getAsString())
//						.tourisName(temp.get("title").getAsString())
//						.tourisAddress(temp.get("addr1")==null?"-":temp.get("addr1").getAsString())
//						.tourisLatitude(temp.get("mapy")==null?"-":temp.get("mapy").getAsString())
//						.tourisLongitude(temp.get("mapx")==null?"-":temp.get("mapx").getAsString())
//						.tourisLevel(temp.get("mlevel")==null?"-":temp.get("mlevel").getAsString())
//						.tourisMainImage(temp.get("firstimage")==null?"-":temp.get("firstimage").getAsString())
//						.tourisPhone(temp.get("tel")==null?"-":temp.get("tel").getAsString())
//						.areaId(temp.get("areacode")==null?"-":temp.get("areacode").getAsString())
//						.build();
//				int testResult=service.insertTest(test);
//				if(testResult >0)System.out.println("성공");
			}
				//System.out.println(list.size());
	}
}

			//여기서부터 상세내용에 대한 api주소 요청
//				List<Object> list2=new ArrayList();
//					StringBuilder commoncontent = new StringBuilder();
//					for(String e:list) {
//							
//						String urlStr2 = "http://apis.data.go.kr/B551011/KorService1/detailCommon1?"
//							+ URLEncoder.encode("serviceKey", "UTF-8") + "="
//							+ URLEncoder.encode(
//									"0906O7Vl32hAkLceKylOGOAzJuIESMtXTXESfLV++obF/XFUtduY0IZn4KnJnwSMB3L5HTj7oRuH8PqFhVAQ6w==",
//									"UTF-8")
//							+ "&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8") + "&"
//							+ URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8") + "&"
//							+ URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8") + "&"
//							+ URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8") + "&"
//							+ URLEncoder.encode("contentId", "UTF-8") + "="
//							+ URLEncoder.encode(e, "UTF-8") + "&"
//							+ URLEncoder.encode("defaultYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8") + "&"
//							+ URLEncoder.encode("addrinfoYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8") + "&"
//							+ URLEncoder.encode("firstImageYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8") + "&"
//							+ URLEncoder.encode("areacodeYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8") + "&"
//							+ URLEncoder.encode("mapinfoYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8") + "&"
//							+ URLEncoder.encode("overviewYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8") + "&"
//							+ URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8") + "&"
//							+ URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8");
//					URL url2 = new URL(urlStr2);
//
//					HttpURLConnection urlConnection2 = (HttpURLConnection) url2.openConnection();
//					urlConnection2.setConnectTimeout(60000);
//					urlConnection2.setReadTimeout(60000);
//					urlConnection2.setRequestMethod("GET");
//
//					BufferedReader br2 = new BufferedReader(
//							new InputStreamReader(urlConnection2.getInputStream(), Charset.forName("UTF-8")));
//
//					String returnLine2;
//
//						while ((returnLine2 = br2.readLine()) != null) {
//							commoncontent.append(returnLine2 + "\n\r");
//						}
//						urlConnection2.disconnect();
//					
//					
//				
//				System.out.println(commoncontent.toString());
//				파싱할 객체 생성
//					JsonParser paraser = new JsonParser();
//					JsonObject obj2 = paraser.parse(commoncontent.toString()).getAsJsonObject();
//					JsonObject obj2 = JsonParser.parseString(commoncontent.toString()).getAsJsonObject();
//					JsonArray arr2 = obj2.get("response").getAsJsonObject().get("body").getAsJsonObject().get("items")
//								.getAsJsonObject().get("item").getAsJsonArray();

//					ObjectMapper mapper=new ObjectMapper();
//					Map jsonData=null;
//					try {
//						jsonData=mapper.readValue(new String(commoncontent), Map.class);
//					}catch(Exception j) {
//						j.printStackTrace();
//					}
//					System.out.println(((Map)jsonData.get("response")));
//					System.out.println(jsonData);

					
//					for (JsonElement jsonElement2 : arr2) {
//						JsonObject temp2 = jsonElement2.getAsJsonObject();
//						System.out.println(temp2);
//						System.out.println("=============================");
//						System.out.println("관광지ID : " + temp2.get("contentid"));
//						System.out.println("관광지명 : " + temp2.get("title"));
//						System.out.println("관광지주소 : " + temp2.get("addr1"));
//						System.out.println("전화번호 : " + temp2.get("tel"));
//						System.out.println("상세내용 : " + temp2.get("overview"));
//						System.out.println("대표이미지 : " + temp2.get("firstimage"));
//						System.out.println("홈페이지주소 : " + temp2.get("hmpg"));
//						System.out.println("위도 : " + temp2.get("mapy"));
//						System.out.println("경도 : " + temp2.get("mapx"));
//						System.out.println("맵레벨 : " + temp2.get("mlevel"));
//						System.out.println("지역코드ID : " + temp2.get("areacode"));
//						
//						list2.add(temp2.get("title"));
//					}
//					System.out.println(list2.size());
//				}
			
//
////						여기서 부터는 관광지에 대한 상세정보드들을 불러올 api 주소
//						StringBuilder details = new StringBuilder();
//
//						String urlStr3 = "http://apis.data.go.kr/B551011/KorService1/detailIntro1?"
//								+ URLEncoder.encode("serviceKey", "UTF-8") + "="
//								+ URLEncoder.encode(
//										"0906O7Vl32hAkLceKylOGOAzJuIESMtXTXESfLV++obF/XFUtduY0IZn4KnJnwSMB3L5HTj7oRuH8PqFhVAQ6w==",
//										"UTF-8")
//								+ "&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8") + "&"
//								+ URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8") + "&"
//								+ URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8") + "&"
//								+ URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")
//								+ "&" + URLEncoder.encode("contentId", "UTF-8") + "="
//								+ URLEncoder.encode(temp2.get("contentid").getAsString(), "UTF-8") + "&"
//								+ URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8") + "&"
//								+ URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8");
//						URL url3 = new URL(urlStr3);
//
//						HttpURLConnection urlConnection3 = (HttpURLConnection) url3.openConnection();
//						urlConnection3.setConnectTimeout(60000);
//						urlConnection3.setReadTimeout(60000);
//						urlConnection3.setRequestMethod("GET");
//						
//						BufferedReader br3 = new BufferedReader(
//								new InputStreamReader(urlConnection3.getInputStream(), Charset.forName("UTF-8")));
//
//						String returnLine3;
//
//						while ((returnLine3 = br3.readLine()) != null) {
//							details.append(returnLine3 + "\n\r");
//						}
//						urlConnection3.disconnect();
////					 	여기서부터 파싱
////						파싱할 객체 생성
//						JsonObject obj3 = JsonParser.parseString(details.toString()).getAsJsonObject();
//						JsonArray arr3 = obj3.get("response").getAsJsonObject().get("body").getAsJsonObject().get("items")
//								.getAsJsonObject().get("item").getAsJsonArray();
//						for (JsonElement jsonElement3 : arr3) {
//							JsonObject temp3 = jsonElement3.getAsJsonObject();
//							System.out.println("체험안내 : " + temp3.get("expguide"));
//							System.out.println("문의및안내 : " + temp3.get("infocenter"));
//							System.out.println("이용시기 : " + temp3.get("useseason"));
//							System.out.println("이용시간 : " + temp3.get("usetime"));
//							System.out.println("주차시설 : " + temp3.get("parking"));
//							System.out.println("개장일 : " + temp3.get("opendate"));
//							System.out.println("쉬는날 : " + temp3.get("restdate"));
//						
//							Test test=Test.builder()
//									.tourisId(temp2.get("contentid").getAsString())
//									.tourisName(temp2.get("title").getAsString())
//									.tourisAddress(temp2.get("addr1")==null?"-":temp2.get("addr1").getAsString())
//									.tourisContent(temp2.get("overview")==null?"-":temp2.get("overview").getAsString())
//									.tourisLatitude(temp2.get("mapy")==null?"-":temp2.get("mapy").getAsString())
//									.tourisLongitude(temp2.get("mapx")==null?"-":temp2.get("mapx").getAsString())
//									.tourisLevel(temp2.get("mlevel")==null?"-":temp2.get("mlevel").getAsString())
//									.tourisMainImage(temp2.get("firstimage")==null?"-":temp2.get("firstimage").getAsString())
//									.tourisPage(temp2.get("hmpg")==null?"-":temp2.get("hmpg").getAsString())
//									.tourisPhone(temp2.get("tel")==null?"-":temp2.get("tel").getAsString())
//									.tourisExperience(temp3.get("expguide")==null?"-":temp3.get("expguide").getAsString())
//									.tourisTel(temp3.get("infocenter")==null?"-":temp3.get("infocenter").getAsString())
//									.tourisUsemonth(temp3.get("useseason")==null?"-":temp3.get("useseason").getAsString())
//									.tourisUsetime(temp3.get("usetime")==null?"-":temp3.get("usetime").getAsString())
//									.tourisParking(temp3.get("parking")==null?"-":temp3.get("parking").getAsString())
//									.tourisStartday(temp3.get("opendate")==null?"-":temp3.get("opendate").getAsString())
//									.tourisDayoff(temp3.get("restdate")==null?"-":temp3.get("restdate").getAsString())
//									.areaId(temp2.get("areacode")==null?"-":temp2.get("areacode").getAsString())
//									.build();
//							//int testResult=service.insertTest(test);
//							//if(testResult >0)System.out.println("성공");
//						}
//			
//	}
//	
//	}



