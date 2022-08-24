package com.jeo.webapp.bankda;

import org.json.simple.JSONObject;
import org.junit.Test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class BankdaTest {
	@Test
	public void postTemplate() {
		String response = null;

		try {
			String urlPath = "https://webhook.site/ddac5181-3d0c-4865-9746-81f3702d524b";
			URL url = new URL(urlPath);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod("POST");
			con.setDoOutput(true);

			String param = "param1=a";
			param += "&param2=b";
			param += "&param3=c";
			param += "&param4=d";

			OutputStream os = con.getOutputStream();
			os.write(param.getBytes("utf-8"));
			os.flush();
			os.close();

			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "euc-kr"));
			StringBuffer sb = new StringBuffer();
			String inputLine;

			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();

			response = sb.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}

		System.out.println(response);
	}

	@Test
	public void postJSONTemplate() {
		String response = null;

		try {
			String urlPath = "https://webhook.site/ddac5181-3d0c-4865-9746-81f3702d524b";
			URL url = new URL(urlPath);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod("POST");
			con.setRequestProperty("Content-type", "application/json");
			con.setDoOutput(true);

			JSONObject jsonObject = new JSONObject();
			jsonObject.put("param1", "a");
			jsonObject.put("param2", "b");
			jsonObject.put("param3", "c");

			OutputStream os = con.getOutputStream();
			os.write(jsonObject.toString().getBytes("utf-8"));
			os.flush();
			os.close();

			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "euc-kr"));
			StringBuffer sb = new StringBuffer();
			String inputLine;

			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();

			response = sb.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}

		System.out.println(response);
	}
}
