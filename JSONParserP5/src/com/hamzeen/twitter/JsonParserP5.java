package com.hamzeen.twitter;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONTokener;

/**
 * @author Hamzeen. H.
 * @created 04/02/2013, 4:36 PM
 */
public class JsonParserP5 {
	private static JsonParserP5 instance = null;

	/**
	 * Stands only to prevent instantiation from other classes.
	 */
	private JsonParserP5() {
	}

	public static synchronized JsonParserP5 getSingelton() {
		if (instance == null) {
			instance = new JsonParserP5();
		}
		return instance;
	}

	public JSONArray parseJson(final String url) {
		JSONArray result = null;
		InputStream inStream = null;
		DataInputStream dataInStream = null;
		String strLine;
		StringBuffer buffer = new StringBuffer();

		try {
			inStream = new URL(url).openStream();
			dataInStream = new DataInputStream(
					new BufferedInputStream(inStream));
			BufferedReader br = new BufferedReader(
					new InputStreamReader(dataInStream));

			while ((strLine = br.readLine()) != null) {
				buffer.append(strLine);
			}
			JSONTokener tokens = new JSONTokener(buffer
					.toString());
			result = new JSONArray(tokens);
		} catch (MalformedURLException mue) {

			System.err
					.println("[JSONParserP5] MalformedURLException, please verify for your URL.");
			mue.printStackTrace();
			System.exit(1);
		} catch (IOException ioe) {

			System.err
					.println("[JSONParserP5] An IO Exception occured.");
			ioe.printStackTrace();
			System.exit(1);
		} finally {
			try {
				inStream.close();
			} catch (IOException ioe) {
				System.err
						.println("[JSONParserP5] IO Exception occured while trying to close the input stream.");
			}
		}
		return result;
	}
}
