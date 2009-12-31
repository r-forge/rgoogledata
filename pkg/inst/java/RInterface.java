package dev;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.google.gdata.client.spreadsheet.FeedURLFactory;
import com.google.gdata.client.spreadsheet.SpreadsheetService;
import com.google.gdata.data.BaseEntry;
import com.google.gdata.data.PlainTextConstruct;
import com.google.gdata.data.spreadsheet.SpreadsheetEntry;
import com.google.gdata.data.spreadsheet.SpreadsheetFeed;
import com.google.gdata.data.spreadsheet.WorksheetEntry;
import com.google.gdata.data.spreadsheet.WorksheetFeed;
import com.google.gdata.util.AuthenticationException;
import com.google.gdata.util.ServiceException;

import com.google.gdata.client.*;
import com.google.gdata.client.GoogleAuthTokenFactory.UserToken;
import com.google.gdata.client.docs.*;
import com.google.gdata.data.DateTime;
import com.google.gdata.data.MediaContent;
import com.google.gdata.data.docs.*;
import com.google.gdata.util.*;
import com.google.gdata.data.extensions.*;
import com.google.gdata.data.media.MediaEntry;
import com.google.gdata.data.media.MediaSource;
import com.google.gdata.data.spreadsheet.Column;
import com.google.gdata.data.spreadsheet.Data;
import com.google.gdata.data.spreadsheet.Header;
import com.google.gdata.data.spreadsheet.ListEntry;
import com.google.gdata.data.spreadsheet.ListFeed;
import com.google.gdata.data.spreadsheet.TableEntry;
import com.google.gdata.data.spreadsheet.Worksheet;

import com.google.gdata.data.Link;
import com.google.gdata.data.acl.AclEntry;
import com.google.gdata.data.acl.AclFeed;
import com.google.gdata.data.acl.AclRole;
import com.google.gdata.data.acl.AclScope;

public class RInterface {
	
  public String Msg;   // keep some errors from GOOG
  public DocsService service; 
  //public GoogleService spreadsheetsService;   //  v1.36
  public SpreadsheetService spreadsheetsService;
  
  public static final String DEFAULT_AUTH_PROTOCOL = "https";
  public static final String DEFAULT_AUTH_HOST = "docs.google.com";

  public static final String DEFAULT_PROTOCOL = "http";
  public static final String DEFAULT_HOST = "docs.google.com";

  public static final String SPREADSHEETS_SERVICE_NAME = "wise";
  public static final String SPREADSHEETS_HOST = "spreadsheets.google.com";

  private final String URL_FEED = "/feeds";
  private final String URL_DOWNLOAD = "/download";
  private final String URL_DOCLIST_FEED = "/private/full";

  private final String URL_DEFAULT = "/default";
  private final String URL_FOLDERS = "/contents";
  private final String URL_ACL = "/acl";
  private final String URL_REVISIONS = "/revisions";

  private static final String URL_GROUP_DOCUMENTS = "/documents";
  private static final String URL_GROUP_SPREADSHEETS = "/spreadsheets";
  private static final String URL_GROUP_FOLDERS = "/folders";
  private static final String URL_GROUP_MEDIA = "/media";
  private static final String URL_GROUP_ACL = "/acl";

  private static final String URL_PATH = "/private/full";

  private static final String URL_CATEGORY_DOCUMENT = "/-/document";
  private static final String URL_CATEGORY_SPREADSHEET = "/-/spreadsheet";
  private static final String URL_CATEGORY_PDF = "/-/pdf";
  private static final String URL_CATEGORY_PRESENTATION = "/-/presentation";
  private static final String URL_CATEGORY_STARRED = "/-/starred";
  private static final String URL_CATEGORY_TRASHED = "/-/trashed";
  private static final String URL_CATEGORY_FOLDER = "/-/folder";
  private static final String URL_CATEGORY_EXPORT = "/Export";

  private static final String PARAMETER_SHOW_FOLDERS = "showfolders=true";
  
  private static final String BASE_ENTRY_DETAILS = "id\ttitle\tauthors\tcanEdit\tetag\tpublished";
  private static final String DOCUMENT_LIST_ENTRY_DETAILS = "key\tfolder\tlastViewed\t" +
    "lastModifiedBy\tlastUpdated\tisViewed\tisWritersCanInvite\t" + 
    "isHidden\tisStarred\thtmlLink\tisTrashed";
  

  private static String applicationName;
  private static String authProtocol;
  private static String authHost;
  private static String protocol;
  private static String host;
  private static String username;
  private static String password;
  private static String authSubToken;

  private static final Map<String, String> DOWNLOAD_DOCUMENT_FORMATS;
  static {
    DOWNLOAD_DOCUMENT_FORMATS = new HashMap<String, String>();
    DOWNLOAD_DOCUMENT_FORMATS.put("doc", "doc");
    DOWNLOAD_DOCUMENT_FORMATS.put("txt", "txt");
    DOWNLOAD_DOCUMENT_FORMATS.put("odt", "odt");
    DOWNLOAD_DOCUMENT_FORMATS.put("pdf", "pdf");
    DOWNLOAD_DOCUMENT_FORMATS.put("png", "png");
    DOWNLOAD_DOCUMENT_FORMATS.put("rtf", "rtf");
    DOWNLOAD_DOCUMENT_FORMATS.put("html", "html");
    DOWNLOAD_DOCUMENT_FORMATS.put("zip", "zip");
  }

  private static final Map<String, String> DOWNLOAD_PRESENTATION_FORMATS;
  static {
    DOWNLOAD_PRESENTATION_FORMATS = new HashMap<String, String>();
    DOWNLOAD_PRESENTATION_FORMATS.put("pdf", "pdf");
    DOWNLOAD_PRESENTATION_FORMATS.put("png", "png");
    DOWNLOAD_PRESENTATION_FORMATS.put("ppt", "ppt");
    DOWNLOAD_PRESENTATION_FORMATS.put("swf", "swf");
  }

  private static final Map<String, String> DOWNLOAD_SPREADSHEET_FORMATS;
  static {
    DOWNLOAD_SPREADSHEET_FORMATS = new HashMap<String, String>();
    DOWNLOAD_SPREADSHEET_FORMATS.put("xls", "xls");
    DOWNLOAD_SPREADSHEET_FORMATS.put("ods", "ods");
    DOWNLOAD_SPREADSHEET_FORMATS.put("pdf", "pdf");
    DOWNLOAD_SPREADSHEET_FORMATS.put("csv", "csv");
    DOWNLOAD_SPREADSHEET_FORMATS.put("tsv", "tsv");
    DOWNLOAD_SPREADSHEET_FORMATS.put("html", "html");
  }
 
  private FeedURLFactory factory;
  
	/********************************************************************
	 * Login
	 * @param userName
	 * @param password
	 ********************************************************************/
	public RInterface(String applicationName) {
	 
	 Msg = "";	
	 try{
	   service = new DocsService(applicationName);   
 	   //spreadsheetsService = new SpreadsheetService(applicationName);  
 	   spreadsheetsService = new SpreadsheetService(applicationName);
	 } catch (Exception ex){
	   Msg = "Exception: " + ex.getMessage() + "\n";  
	 }	 
   
   this.applicationName = applicationName;
   this.authProtocol = DEFAULT_AUTH_PROTOCOL;
   this.authHost = DEFAULT_AUTH_HOST;
   this.protocol = DEFAULT_PROTOCOL;
   this.host = DEFAULT_HOST;
	
	}
	
  /**
   * Set user credentials based on a username and password.
   *
   * @param username to log in with.
   * @param password password for the user logging in.
   *
   * @throws AuthenticationException
   * @throws DocumentListException
   */
  public void login(String username, String password)  {
    
    this.username = username;
    this.password = password;
    this.authSubToken = "";
     
    Msg = "";
    
    try{
      service.setUserCredentials(username, password);
      spreadsheetsService.setUserCredentials(username, password);
    } catch (Exception ex){
 	    Msg = "Exception: " + ex.getMessage() + "\n";    	
    }
  }
  
	 /********************************************************************
   * Get the details for a DocumentListEntry.  For each DocumentListEntry, a list of elements separated by tabs
   ********************************************************************/
	public String getDocumentListEntries(String type){
		
		StringBuffer out = new StringBuffer();
		out.append(BASE_ENTRY_DETAILS);
		out.append("\t"+ DOCUMENT_LIST_ENTRY_DETAILS + "\n");
		Msg = "";
		
		//String url = "http://docs.google.com/feeds/default/private/full/";
		String url = "http://docs.google.com" + URL_FEED + URL_DEFAULT + URL_DOCLIST_FEED;
		if (type.equals("document")){
			url = url + "/-/document";
		} else if (type.equals("spreadsheet")){
			url = url + "/-/spreadsheet";
		} else if (type.equals("presentations")){
			url = url + "/-/presentation/mine";
		} else if (type.equals("folder")){
			url = url + "/-/folder?showfolders=true";
		}
		
		try{
      URL documentListFeedUrl = new URL(url);
		
      DocumentListFeed feed = service.getFeed(documentListFeedUrl, 
        DocumentListFeed.class);
      
      for (DocumentListEntry doc : feed.getEntries()){
   	    out.append(getBaseEntryDetails(doc));
   	    out.append(getDocumentListEntryDetails(doc));
  	    out.append("\n");    
      }
		} catch (Exception ex) {
			Msg = "Exception: " + ex.getMessage() + "\n";
		}
		
		return out.toString();
 }
	
	/*
	 * Spreadsheet entries have different Id's than the ones returned by the 
	 * DocumentList API.  This makes it impossible to use the same Id for file 
	 * operations (e.g. delete, move, etc.) and spreadsheet operations (getContents, 
	 * etc.)
	 *   
	 */
	public String getSpreadsheetListEntries() throws IOException, ServiceException{
	  StringBuffer out = new StringBuffer();
      out.append(BASE_ENTRY_DETAILS);
      //out.append("\t"+ DOCUMENT_LIST_ENTRY_DETAILS);
      out.append("\n");
      
      //http://spreadsheets.google.com/feeds/spreadsheets/private/full
      String url = "http://spreadsheets.google.com" + URL_FEED + URL_GROUP_SPREADSHEETS + URL_DOCLIST_FEED;
      URL spreadsheetsFeedUrl = new URL(url);      
      SpreadsheetFeed feed = spreadsheetsService.getFeed(spreadsheetsFeedUrl,
          SpreadsheetFeed.class);
      
      for (SpreadsheetEntry spreadsheet : feed.getEntries()){
        out.append(getBaseEntryDetails(spreadsheet));
        //out.append(getDocumentListEntryDetails(spreadsheet));
        out.append("\n");    
      }
	  
      return out.toString();
	}
	
	/**
	 * Get details for one spreadsheet.  Pass the full worksheetFeedUrl. 
	 */
	public String getWorksheetEntries(String worksheetFeedUrlString) 
	  throws MalformedURLException, IOException, ServiceException{
		
      StringBuffer out = new StringBuffer();
      //add the column names
      out.append(BASE_ENTRY_DETAILS + "\tnrow\tncol\n");
      
      URL worksheetFeedUrl = new URL(worksheetFeedUrlString);
      //System.out.println(worksheetFeedUrl.toString());
      
      WorksheetFeed worksheetFeed = spreadsheetsService.getFeed(worksheetFeedUrl,
        WorksheetFeed.class);
      for (WorksheetEntry worksheet : worksheetFeed.getEntries()) {
        out.append(getBaseEntryDetails(worksheet));
        out.append(worksheet.getRowCount() + "\t" + worksheet.getColCount() + "\n");
      }
		
      return out.toString();
	}	
	
	public String getTableEntries(String spreadsheetId) 
      throws MalformedURLException, IOException, ServiceException{
	
  	StringBuffer out = new StringBuffer();
	  //add the column names
	  out.append(BASE_ENTRY_DETAILS + "\tnrow\tncol\n");
	  URL url = new URL(spreadsheetId);
    SpreadsheetEntry spreadsheet = spreadsheetsService.getEntry(url, SpreadsheetEntry.class);
	
  	URL worksheetFeedUrl = spreadsheet.getWorksheetFeedUrl();
    WorksheetFeed worksheetFeed = spreadsheetsService.getFeed(worksheetFeedUrl,
        WorksheetFeed.class);
    for (WorksheetEntry worksheet : worksheetFeed.getEntries()) {
      out.append(getBaseEntryDetails(worksheet));
      out.append(worksheet.getRowCount() + "\t" + worksheet.getColCount() + "\n");
    }
	
	  return out.toString();
  }	
	
	public String getListEntries(String worksheetId) 
    throws IOException, ServiceException, DocumentListException{  
	
  	Msg = "";
	  StringBuffer out = new StringBuffer();
		out.append(BASE_ENTRY_DETAILS + "\n");
    
	  URL url = new URL(worksheetId);
	  ListFeed feed = spreadsheetsService.getFeed(url, ListFeed.class);
	
  	for (ListEntry entry : feed.getEntries()) {                // loop over rows
  		out.append(getBaseEntryDetails(entry));
	 //   for (String tag : entry.getCustomElements().getTags())   // loop over columns
	 //     out.append(tag + "\t" + entry.getCustomElements().getValue(tag) + "\t");
	    out.append("\n");
	  }

	return out.toString();
}
	
	public String getContentListEntry(String listEntryId) throws IOException, ServiceException{
		
	  StringBuffer out = new StringBuffer();
    
	  URL url = new URL(listEntryId);
	  ListEntry entry = spreadsheetsService.getEntry(url, ListEntry.class);
	
	  for (String tag : entry.getCustomElements().getTags())   // loop over columns
	    out.append(tag + "\t" + entry.getCustomElements().getValue(tag) + "\t");
	
	  return out.toString();
	}
	
  /**
   * Adds a new list entry, based on the user-specified name value pairs separated 
   * by \t.  A new list entry is separated by \n.
   * 
   * @param nameValuePairs pairs such as "name=Rosa,phone=555-1212"
   * @throws ServiceException when the request causes an error in the Google
   *         Spreadsheets service.
   * @throws IOException when an error occurs in communication with the Google
   *         Spreadsheets service.
   */
  public void addListEntry(String worksheetId, String nameValuePairs) {
  	
  	Msg = "";
  	try{
  	  URL url = new URL(worksheetId);
	    WorksheetEntry worksheet = spreadsheetsService.getEntry(url, WorksheetEntry.class);
	    URL listFeedUrl = worksheet.getListFeedUrl();
	    //ListFeed listFeedUrl = spreadsheetsService.getFeed(url, ListFeed.class);
  	
    	String[] entriesContent = nameValuePairs.split("\n");
  	
  	  for (int i=0; i<entriesContent.length; i++){
        ListEntry newEntry = new ListEntry();
        setListEntryContentsFromString(newEntry, entriesContent[i]);
        spreadsheetsService.insert(listFeedUrl, newEntry);
  	  }
  	  Msg = "TRUE";
	  } catch (Exception ex){
		  Msg = "Exception: " + ex.getMessage();
	  }
  }

  public void updateListEntry(String listEntryId, String nameValuePairs) {
    
  	Msg = "";
  	try{
      String[] entriesId = listEntryId.split("\n");
      String[] entriesContent = nameValuePairs.split("\n");

      for (int i=0; i<entriesContent.length; i++){
        URL entryUrl = new URL(entriesId[i]);
        ListEntry entry = spreadsheetsService.getEntry(entryUrl, ListEntry.class);
        setListEntryContentsFromString(entry, entriesContent[i]);
        entry.update();
        //spreadsheetsService.insert(listFeedUrl, entry);
      }
      Msg = "TRUE";
    } catch (Exception ex){
	    Msg = "Exception: " + ex.getMessage();
    }
  
  }

  public void deleteListEntry(String listEntryId) {
    
  	Msg = "";
  	try{
      String[] entriesId = listEntryId.split("\n");
      
      for (int i=0; i<entriesId.length; i++){
        URL entryUrl = new URL(entriesId[i]);
        ListEntry entry = spreadsheetsService.getEntry(entryUrl, ListEntry.class);
        entry.delete();
      }
      Msg = "TRUE";
    } catch (Exception ex){
	    Msg = "Exception: " + ex.getMessage();
    }
  
  }

	
	/********************************************************************
   * Do a full text query and return a list of documents that contain
   * the querytxt string.  Exact matches only!
   ********************************************************************/
	public String fullTextQuery(String querytxt){
		
		String out = "";
		Msg = "";
		
		try {
  		URL feedUri = new URL("http://docs.google.com/feeds/documents/private/full/");
	  	DocumentQuery query = new DocumentQuery(feedUri);
		  query.setFullTextQuery(querytxt);
		  DocumentListFeed feed = service.getFeed(query, DocumentListFeed.class);
		  
		  for (DocumentListEntry doc : feed.getEntries()){
		  	out = out + doc.getTitle().getPlainText() + "\n";
		  }
		} catch (Exception ex){
			Msg = "Exception: " + ex.getMessage() + "\n";
		}
		
		return out;
	}
	
	public void newDocument(String name, String type, String inFolderId){

		Msg = "";
		String uri = "http://docs.google.com" + URL_FEED; 
		
		if (!inFolderId.equals("")){
			uri = uri + "folders/private/full/" + inFolderId;
		} else {
			uri = uri + URL_DEFAULT + URL_DOCLIST_FEED;  //"default/private/full";
		}

	  DocumentListEntry newEntry = null;
	  try {
  	  if (type.equals("document")) {
	      newEntry = new DocumentEntry();
	    } else if (type.equals("presentation")) {
	      newEntry = new PresentationEntry();
	    } else if (type.equals("spreadsheet")) {
	      //newEntry = new SpreadsheetEntry();         // Should work but doesn't.  See newSpreadsheet.
	    } else if (type.equals("folder")) {
	    	newEntry = new FolderEntry();
	    }
	    newEntry.setTitle(new PlainTextConstruct(name));
	    service.insert(new URL(uri), newEntry);
	    Msg = "TRUE";
	  } catch (Exception ex) {
			Msg = "Exception: " + ex.getMessage() + "\n";
		}
	  
	  return; 	  
	}
  
	public void newSpreadsheet(String name, String inFolderId){

		Msg = "";
		String uri = "http://docs.google.com/feeds/"; 
		
		if (!inFolderId.equals("")){
			uri = uri + "folders/private/full/" + inFolderId;
		} else {
			uri = uri + "documents/private/full";
		}

		SpreadsheetEntry createdEntry = null;
	  SpreadsheetEntry newEntry = null;
	  try {
      newEntry = new SpreadsheetEntry();         // FIX ME!!!
	    newEntry.setTitle(new PlainTextConstruct(name));
	    createdEntry = service.insert(new URL(uri), newEntry);
	    Msg = "spreadsheet now online @ :" + createdEntry.getHtmlLink().getHref();
	  } catch (Exception ex) {
			Msg = "Exception: " + ex.getMessage() + "\n";
		}
	  
	  return; 	  
	}
	
	public void addWorksheet(String sheetName, int rowCount, int colCount, String worksheetFeedUrlString){
		
	  try{		 
	    URL worksheetFeedUrl = new URL(worksheetFeedUrlString); 
	      
  		WorksheetEntry worksheet = new WorksheetEntry();
        worksheet.setTitle(new PlainTextConstruct(sheetName));
        worksheet.setRowCount(rowCount);
        worksheet.setColCount(colCount);
        spreadsheetsService.insert(worksheetFeedUrl, worksheet);
        Msg = "TRUE";
	  } catch (Exception ex){
		Msg = "Exception: " + ex.getMessage();
	  }
    
	}
	
	/**
	 * Create a TableEntry on a NEW sheet of the spreadsheet.
	 */
    public void newTableEntry(String title, int headerRowIndex, int noRows, int startRowIndex, 
  	  String spreadsheetId, String worksheetName, String allColumnNames){
		
		try{
			TableEntry tableEntry = new TableEntry();
			
			URL url = new URL(spreadsheetId);
	    SpreadsheetEntry spreadsheet = spreadsheetsService.getEntry(url, SpreadsheetEntry.class);
	    URL tableFeedUrl = new URL(url.getProtocol() + "://" + url.getHost().toString() + 
	    		"/feeds" + spreadsheet.getKey() + "/tables");
	    		
		// Specify a basic table:
			tableEntry.setTitle(new PlainTextConstruct(title));
			tableEntry.setWorksheet(new Worksheet(worksheetName));  // not a WorksheetEntry!
			tableEntry.setHeader(new Header(headerRowIndex));

			// Specify columns in the table, start row, number of rows.
			Data tableData = new Data();
			tableData.setNumberOfRows(0);
			// Start row index cannot overlap with header row.
			tableData.setStartIndex(startRowIndex);
			
			// Add columns
			String[] colNames = allColumnNames.split("\t");
			for(int i=0; i<colNames.length; i++)
  			tableData.addColumn(new Column(new Integer(i+1).toString(), colNames[i]));

			tableEntry.setData(tableData);
			spreadsheetsService.insert(tableFeedUrl, tableEntry);
			
      Msg = "TRUE";
		} catch (Exception ex){
			Msg = "Exception: " + ex.getMessage();
		}
    
	}
	
	public void deleteWorksheet(String worksheetEntryUrlString) {
		
		try{
  		URL url = new URL(worksheetEntryUrlString);
	    WorksheetEntry worksheet = spreadsheetsService.getEntry(url, WorksheetEntry.class);	  
      worksheet.delete();
      Msg = "TRUE";
    } catch (Exception ex){
			Msg = "Exception: " + ex.getMessage();
		}
  }
	
	/*
	 * folderId = "folder%3A0Bx8m8jO_88FPN2Y0MmUzYmQtYTY1Zi00ODZjLTkzN2QtYTM5YTJjMDc1NDU4"         
	 */
	public void moveDocumentToFolder(String docId, String toFolderId){
 	
      try{
     	DocumentListEntry doc = new DocumentListEntry();
        doc.setId(buildUrl(URL_DEFAULT + URL_DOCLIST_FEED + "/" + docId).toString());
 
        //URL urlTo =  buildUrl(URL_GROUP_FOLDERS + URL_PATH + "/" + toFolderId);  -- v1.36
        URL urlTo =  buildUrl(URL_DEFAULT + URL_DOCLIST_FEED + "/" + toFolderId + URL_FOLDERS);
        service.insert(urlTo, doc);
        Msg = "TRUE";
	  } catch (Exception ex) {
		Msg = "Exception: " + ex.getMessage() + "\n";
	  }		
	}
	
	/**
	 * Read a work sheet using a list feed.  worksheetId is the full name spreadsheetId + worksheetId 
	 * @throws ServiceException 
	 * @throws IOException 
	 */
	/*public String readWorksheetListFeed(String spreadsheetId, String sheetname) 
	  throws IOException, ServiceException{
		
		Msg = "";
		StringBuffer out = new StringBuffer();
    Boolean getCols  = true;
		
		SpreadsheetEntry spreadsheet = getSpreadsheetEntry(spreadsheetId);
		WorksheetEntry worksheetEntry = getWorksheetEntry(spreadsheet, sheetname);
		if (Msg.equals("")){
			Msg = "Cannot find sheet with name:" + sheetname;
			return "";
		}
		
		URL listFeedUrl = worksheetEntry.getListFeedUrl();
		ListFeed feed = spreadsheetsService.getFeed(listFeedUrl, ListFeed.class);
		System.out.println(listFeedUrl.toString()+ "\n");
		
		for (ListEntry entry : feed.getEntries()) {                  // loop over rows
		  //System.out.println(entry.getTitle().getPlainText());
  		out.append(entry.getId().substring(entry.getId().lastIndexOf('/') + 1) + "\t");
	  	if (getCols){
	  		for (String tag : entry.getCustomElements().getTags()) 
	  		  out.append(tag + "\t");
	  		getCols = false;
	  		out.append("\n");
	  		continue;
	  	}
		  for (String tag : entry.getCustomElements().getTags())   // loop over columns
		    out.append(entry.getCustomElements().getValue(tag) + "\t");
		  out.append("\n");
		}
	
		return out.toString();
	}
	*/
	
  /**
   * Remove a document from a folder and put it in home  
  **/
	public void removeDocumentFromFolder(String docId, String inFolderId) {
		
  	Msg = "";
    
    try{
      URL url =  buildUrl(URL_DEFAULT + URL_DOCLIST_FEED + "/" + inFolderId + URL_FOLDERS + "/" + docId); 
      service.delete(url, getDocsListEntry(docId).getEtag());   // move from folder to home   
      Msg = "TRUE";	
		} catch (Exception ex) {
			Msg = "Exception: " + ex.getMessage() + "\n";
		}
	}
	
	public void trashDocument(String docId, boolean delete){
    
    try{  		
		  String feedUrl = URL_DEFAULT + URL_DOCLIST_FEED + "/" + docId;
		  if (delete) {
		      feedUrl += "?delete=true";
		    }
		  service.delete(buildUrl(feedUrl), getDocsListEntry(docId).getEtag());     // delete from home
		  Msg = "TRUE";
		
		} catch (Exception ex) {
			Msg = "Exception: " + ex.getMessage() + "\n";
		}
	
	}
	
	public void downloadDocument(String docId, String filepath, String format, String sheetIndex) 
	  throws DocumentListException, IOException, ServiceException {
		
      URL url;
      
      // if docId="spreadsheet%3AttXrIUcU402o2GV2jsGsF0g" 
      String id = getObjectIdSuffix(docId);        // id="ttXrIUcU402o2GV2jsGsF0g"
      String docType = getObjectIdPrefix(docId);   // docType="spreadsheet" 
    
      if (docType.equals("spreadsheet")) {
        //UserToken docsToken = (UserToken) service.getAuthTokenFactory().getAuthToken();
        UserToken spreadsheetsToken = (UserToken) spreadsheetsService
          .getAuthTokenFactory().getAuthToken();
        service.setUserToken(spreadsheetsToken.getValue());
        
        HashMap<String, String> parameters = new HashMap<String, String>();
        parameters.put("key", id);
        parameters.put("exportFormat", format);
        if (format.equals(DOWNLOAD_SPREADSHEET_FORMATS.get("csv")) ||
          format.equals(DOWNLOAD_SPREADSHEET_FORMATS.get("tsv"))) {
          parameters.put("gid", sheetIndex);  // download only the sheet specified
        }

        url = buildUrl(SPREADSHEETS_HOST, URL_DOWNLOAD + "/" + docType + "s" + 
                       URL_CATEGORY_EXPORT, parameters);

      } else {
        
        String[] parameters = {"docID=" + id, "exportFormat=" + format};
        url = buildUrl(URL_DOWNLOAD + "/" + docType + "s" +
                       URL_CATEGORY_EXPORT, parameters);
      }

      downloadFile(url, filepath); 		
      
	}
	
	public void uploadDocument(String filepath, String name, String inFolderId){
		
		Msg = "";
	  File file = new File(filepath);

		String uri = "http://docs.google.com/feeds/"; 
		
		if (!inFolderId.equals("")){
			uri = uri + "folders/private/full/" + inFolderId;
		} else {
			uri = uri + "documents/private/full";
		}
	  
	  try {
  	  DocumentListEntry newDocument = new DocumentListEntry();
	    String mimeType = DocumentListEntry.MediaType.fromFileName(file.getName()).getMimeType();
	    newDocument.setFile(new File(filepath), mimeType);
	    newDocument.setTitle(new PlainTextConstruct(name));

  	  service.insert(new URL(uri), newDocument);
  	  Msg = "TRUE";
	  } catch (Exception ex) {
			Msg = "Exception: " + ex.getMessage() + "\n";
		}
	  return;
	}
	
	/*
	 * the spreadsheetId should be everything after the %3A field!
	 */
/*	public String listAllWorksheets(String spreadsheetId) throws IOException, 
	  ServiceException, DocumentListException{
		
		Msg = "";
		String out="";
		String root = "http://spreadsheets.google.com/feeds/spreadsheets/";
		spreadsheetId = root + spreadsheetId;
		
		// Strange enough, you have to loop through the spreadsheet feed, cannot point 
		// straight to the one you want.  Maybe I don't understand it right.
		URL url = new URL(root + "private/full");
		SpreadsheetFeed spreadsheetFeed = spreadsheetsService.getFeed(url, SpreadsheetFeed.class);
	  for (SpreadsheetEntry spreadsheet : spreadsheetFeed.getEntries()) {
	  	
      if (spreadsheetId.equals(spreadsheet.getId())){
  	  	URL worksheetFeedUrl = spreadsheet.getWorksheetFeedUrl();
  	  	WorksheetFeed worksheetFeed = spreadsheetsService.getFeed(worksheetFeedUrl,
  	        WorksheetFeed.class);
          
  	    for (WorksheetEntry worksheet : worksheetFeed.getEntries()) {
  	      String title = worksheet.getTitle().getPlainText();
  	      int rowCount = worksheet.getRowCount();
  	      int colCount = worksheet.getColCount();
  	      out = out + title + "\n" + rowCount + "\n" + colCount + "\n";
  	    }

      	break;
      }
    }
		
	  if (out.equals("")){
	  	Msg = "Cannot find spreadsheet!";
	  	return "";
	  }
			
		return out;
	}
	*/
	//***************************************************************************
  public String getMsg(){
  	return Msg;
  }
	public void clearMsgBuffer(){
		Msg="";
	}

	private WorksheetEntry getWorksheetEntry(SpreadsheetEntry spreadsheet, String sheetname) 
	  throws IOException, ServiceException{
		
		Msg = "";
		WorksheetEntry thisWorksheet = new WorksheetEntry();
		
		URL worksheetFeedUrl = spreadsheet.getWorksheetFeedUrl();
    WorksheetFeed worksheetFeed = spreadsheetsService.getFeed(worksheetFeedUrl,WorksheetFeed.class);
    for (WorksheetEntry worksheet : worksheetFeed.getEntries()) {
      String title = worksheet.getTitle().getPlainText();
      if (sheetname.equals(title)){
      	thisWorksheet = worksheet;
      	Msg = "Worksheet found!";
      	break;
      }
    }
	
		return thisWorksheet;
	}
	
	/**
	 * Get the spreadsheet entry from the spreadsheet id. 
	 */
	private SpreadsheetEntry getSpreadsheetEntry(String spreadsheetId) throws IOException,
  MalformedURLException, ServiceException {
		
		Msg = "";
		String root = "http://spreadsheets.google.com/feeds/spreadsheets/";
		spreadsheetId = root + spreadsheetId;
		SpreadsheetEntry thisSpreadsheet = new SpreadsheetEntry(); 
		
		// Strange enough, you have to loop through the spreadsheet feed, cannot point 
		// straight to the one you want.  Maybe I don't understand it right.
		URL url = new URL(root + "private/full");
		SpreadsheetFeed spreadsheetFeed = spreadsheetsService.getFeed(url, SpreadsheetFeed.class);
	  for (SpreadsheetEntry spreadsheet : spreadsheetFeed.getEntries()) {
      if (spreadsheetId.equals(spreadsheet.getId())){
      	thisSpreadsheet = spreadsheet;
      	Msg = "Spreadsheet found";
      	break;
      }
    }
	  return thisSpreadsheet;
	}
  /**
   * Gets the document entry for the provided object id.
   *
   * @param objectId the id of the object to return the entry for.
   *
   * @throws IOException
   * @throws MalformedURLException
   * @throws ServiceException
   * @throws DocumentListException
   */
  private DocumentListEntry getDocsListEntry(String objectId) throws IOException,
      MalformedURLException, ServiceException, DocumentListException {
    if (objectId == null) {
      throw new DocumentListException();
    }

    URL url = buildUrl(URL_DEFAULT + URL_DOCLIST_FEED + "/" + objectId);

    return service.getEntry(url, DocumentListEntry.class);
  }

  /**
   * Gets the Etag for the given object id.
   *
   * @param objectId id of the object to get the etag for.
   *
   * @throws IOException
   * @throws MalformedURLException
   * @throws ServiceException
   * @throws DocumentListException
   */
  private String getObjectEtag(String objectId) throws IOException, MalformedURLException,
      ServiceException, DocumentListException {
    if (objectId == null) {
      throw new DocumentListException();
    }

    DocumentListEntry doc = getDocsListEntry(objectId);

    return doc.getEtag();
  }

  /**
  *
  * @param path the path to add to the protocol/host
  *
  * @throws MalformedURLException
  * @throws DocumentListException
  */
 private URL buildUrl(String path) throws MalformedURLException, DocumentListException {
   if (path == null) {
     throw new DocumentListException();
   }

   return buildUrl(path, null);
 }

 /**
  * Builds a URL with parameters.
  *
  * @param path the path to add to the protocol/host
  * @param parameters parameters to be added to the URL.
  *
  * @throws MalformedURLException
  * @throws DocumentListException
  */
 private URL buildUrl(String path, String[] parameters)
     throws MalformedURLException, DocumentListException {
   if (path == null) {
     throw new DocumentListException();
   }

   return buildUrl(DEFAULT_HOST, path, parameters);
 }

 /**
  * Builds a URL with parameters.
  *
  * @param host the domain of the server
  * @param path the path to add to the protocol/host
  * @param parameters parameters to be added to the URL.
  *
  * @throws MalformedURLException
  * @throws DocumentListException
  */
 private URL buildUrl(String host, String path,  String[] parameters)
     throws MalformedURLException, DocumentListException {
   if (path == null) {
     throw new DocumentListException();
   }

   StringBuffer url = new StringBuffer();
   url.append(protocol + "://" + host + URL_FEED + path);

   if (parameters != null && parameters.length > 0) {
     url.append("?");
     for (int i = 0; i < parameters.length; i++) {
       url.append(parameters[i]);
       if (i != (parameters.length - 1)) {
         url.append("&");
       }
     }
   }

   return new URL(url.toString());
 }

 /**
  * Builds a URL with parameters.
  *
  * @param host the domain of the server
  * @param path the path to add to the protocol/host
  * @param parameters parameters to be added to the URL as key value pairs.
  *
  * @throws MalformedURLException
  * @throws DocumentListException
  */
 private URL buildUrl(String host, String path, Map<String, String> parameters)
 throws MalformedURLException, DocumentListException {
   if (path == null) {
     throw new DocumentListException();
   }

   StringBuffer url = new StringBuffer();
   url.append(protocol + "://" + host + URL_FEED + path);

   if (parameters != null && parameters.size() > 0) {
     Set<Map.Entry<String, String>> params = parameters.entrySet();
     Iterator<Map.Entry<String, String>> itr = params.iterator();

     url.append("?");
     while (itr.hasNext()) {
       Map.Entry<String, String> entry = itr.next();
       url.append(entry.getKey() + "=" + entry.getValue());
       if (itr.hasNext()) {
         url.append("&");
       }
     }
   }

   return new URL(url.toString());
 }

 /**
  * Gets the suffix of the objectId.  If the objectId is "document%3Adh3bw3j_0f7xmjhd8",
  *     "dh3bw3j_0f7xmjhd8" will be returned.
  *
  * @param objectId id to extract the suffix from.
  *
  * @throws DocumentListException
  */
 private String getObjectIdSuffix(String objectId) {
   if (objectId == null || objectId.indexOf("%3A") == 0) {
     Msg = Msg + "null objectId\n";
   }

   return objectId.substring(objectId.lastIndexOf("%3A") + 3);
 }

 /**
  * Gets the prefix of the objectId.  If the objectId is "document%3Adh3bw3j_0f7xmjhd8",
  *     "document" will be returned.
  *
  * @param objectId id to extract the suffix from.
  *
  * @throws DocumentListException
  */
 private String getObjectIdPrefix(String objectId) {
   if (objectId == null || objectId.indexOf("%3A") == 0) {
     Msg = Msg + "null objectId\n";
   }

   return objectId.substring(0, objectId.indexOf("%3A"));
 }

 
 
	private <E extends BaseEntry<E>> String getBaseEntryDetails(E entry){
		
		StringBuffer out = new StringBuffer();
		
		//Make sure to update BASE_ENTRY_DETAILS if you add more
		out.append(entry.getId() + "\t");
		out.append(entry.getTitle().getPlainText() + "\t");  // title
		out.append(entry.getAuthors() + "\t");
    out.append(entry.getCanEdit() + "\t");
    out.append(entry.getEtag() + "\t");
    DateTime published = entry.getPublished();
    if (published != null)
      out.append(published);
    out.append("\t");
	
		return out.toString();
	}
	
  private String getDocumentListEntryDetails(DocumentListEntry doc){
		
		StringBuffer out = new StringBuffer();
		
		//Make sure to update DOCUMENT_LIST_ENTRY_DETAILS if you add more
    out.append(doc.getKey() + "\t");
    
    // print the parent folder the document is in
    if (!doc.getFolders().isEmpty()) {
      out.append(doc.getFolders());
    }
     out.append("\t");
     
     // print the timestamp the document was last viewed
     DateTime lastViewed = doc.getLastViewed();
     if (lastViewed != null) {
       out.append(lastViewed.toString());
     }
    out.append("\t");
    
    // print who made that modification
    LastModifiedBy lastModifiedBy = doc.getLastModifiedBy();
    if (lastModifiedBy != null) {
      out.append(lastModifiedBy.getName() + "/" + lastModifiedBy.getEmail());
    }
    out.append("\t");   
   
    out.append(doc.getUpdated().toString() + "\t"); 
    out.append(doc.isViewed() + "\t"); 
    out.append(doc.isWritersCanInvite().toString() + "\t"); 
    out.append(doc.isHidden() + "\t");
    out.append(doc.isStarred() + "\t");
    out.append(doc.getHtmlLink().getHref() + "\t"); 
	  out.append(doc.isTrashed() + "\t");
	  
		return out.toString();
	}
	
 /**
  * Get the details of SpreadsheetData used by TableEntry
  */
  private String getSpreadsheetDataDetails(Data data){
	
	  StringBuffer out = new StringBuffer();
	
	  out.append(data.getInsertionMode().name() + "\t");
	  out.append(data.getStartIndex() + "\t");
	  out.append(data.getNumberOfRows() + "\t");
	
  	for (Column col: data.getColumns()) {
	  	out.append(col.getIndex() + "\t" + col.getName());	
  	}
	
	  return out.toString();
  }

  
  /**
   * Parses a list of the format "name\tFred\tage\t20\tfriend\tWilma", and sets the
   * corresponding values in the list entry.
   * 
   * Values that are not specified are left alone. That is, if the entry already
   * contains "haircolor=black", then setting name, age, and friend will retain
   * the haircolor as black.
   * 
   * @param entryToChange the entry to change based on the parameters
   * @param nameValuePairs the list of name/value pairs, containing the name of
   *        the title (in lowercase with all invalid characters removed), .
   */
  private void setListEntryContentsFromString(ListEntry entryToChange,
      String nameValuePairs) {
  	
  	String[] pairs = nameValuePairs.split("\t");
  	int noEntries = pairs.length/2;
  	
    // Split first by the commas between the different fields.
  	for (int i=0; i<noEntries; i++){
      String tag   = pairs[2*i];   // such as "name"
      String value = pairs[2*i+1]; // such as "Fred"

      entryToChange.getCustomElements().setValueLocal(tag, value);
    }
  }

  
  /**
   * Downloads a file.
   *
   * @param exportUrl the full url of the export link to download the file from.
   * @param filepath path and name of the object to be saved as.
   *
   * @throws IOException
   * @throws MalformedURLException
   * @throws ServiceException
   * @throws DocumentListException
   */
  public void downloadFile(URL exportUrl, String filepath) throws IOException,
      MalformedURLException, ServiceException, DocumentListException {
    if (exportUrl == null || filepath == null) {
      throw new DocumentListException("null passed in for required parameters");
    }

    MediaContent mc = new MediaContent();
    mc.setUri(exportUrl.toString());
    MediaSource ms = service.getMedia(mc);

    InputStream inStream = null;
    FileOutputStream outStream = null;

    try {
      inStream = ms.getInputStream();
      outStream = new FileOutputStream(filepath);

      int c;
      while ((c = inStream.read()) != -1) {
        outStream.write(c);
      }
    } finally {
      if (inStream != null) {
        inStream.close();
      }
      if (outStream != null) {
        outStream.flush();
        outStream.close();
      }
    }
  }

  
}


