
import dev.RInterface;


public class testRInterface {
	
	public static void main(String[] args){ 
	
	  // Inspired by java/sample/docs/DocumentList.java
	  RInterface R = new RInterface("R Docs Interface");
	  R.login("rdocsdemo@gmail.com", "RGooglePass12");
				
	  String aux = R.getDocumentListEntries("spreadsheet"); // or "folder", "document", "presentation", "spreadsheet"
	  //String aux = R.fullTextQuery("virginica");
	  System.out.println(aux);
  
	  //String docId = "document%3A0AR8m8jO_88FPZGZ0NWg5dzlfMjZ3aHd0MnhjcA"; 
	  //String spreadsheetId = "spreadsheet%3AttXrIUcU402o2GV2jsGsF0g";
	  String spreadsheetId = "spreadsheet%3A0Ah8m8jO_88FPdHRYcklVY1U0MDJvMkdWMmpzR3NGMGc";
	  //String folderId = "folder%3A0Bx8m8jO_88FPN2Y0MmUzYmQtYTY1Zi00ODZjLTkzN2QtYTM5YTJjMDc1NDU4";  // R folder
	  //String worksheetFeedUrlString ="http://spreadsheets.google.com/feeds/worksheets/ttXrIUcU402o2GV2jsGsF0g/private/full";  // testxls 
	  
	  //R.newDocument("test1234", "document", "");
	  //R.newDocument("dir1", "folder", "");
	  //R.newDocument("dir2", "folder", "folder%3A7f42e3bd-a65f-486c-937d-a39a2c075458");
	  //R.moveDocumentToFolder(docId, folderId);        // works
      //R.removeDocumentFromFolder(docId, folderId);      // works 
	  //R.trashDocument(docId, false);
	   
	  
	  
	  //R.uploadDocument("C:/Temp/RLicense.txt", "RLicense", "");
	  try{
	    //R.downloadDocument("spreadsheet%3Ate-a0B-G6X1dfZ0tD5AH9vA", "C:/Temp/Downloads/iris.xls", "xls", "0");
	    R.downloadDocument(spreadsheetId, "C:/Temp/Downloads/testxls.xls", "xls", "0");
        //R.downloadDocument("spreadsheet%3ApIeN6g2qaEvd6a8sgJXSfHA", "C:/Temp/Downloads/oncall.xls", "xls", "0");
        //R.downloadDocument("spreadsheet%3A0Ah8m8jO_88FPdFp6bHhEd1N2dVJnWlU5OGtuZ1NLN3c", "C:/Temp/Downloads/oncall5.csv", "csv", "5");
	    //String bux = R.getSpreadsheetListEntries();
	  	//String bux = R.getWorksheetEntries(worksheetFeedUrlString);
	  	//R.addWorksheet("mySheet", 100, 5, worksheetFeedUrlString);
	  	//R.deleteWorksheet("http://spreadsheets.google.com/feeds/worksheets/ttXrIUcU402o2GV2jsGsF0g/private/full/od3");	  	
	  	//String bux = R.getListEntries("http://spreadsheets.google.com/feeds/list/ttXrIUcU402o2GV2jsGsF0g/od6/private/full");
	  	//String bux = R.getContentListEntry("http://spreadsheets.google.com/feeds/list/ttXrIUcU402o2GV2jsGsF0g/od6/private/full/cokwr");
	  	//R.newTableEntry("firstTable", 3, 10, 4, "http://spreadsheets.google.com/feeds/spreadsheets/ttXrIUcU402o2GV2jsGsF0g", 
	  	//		"no3", "Flopsy\tMopsy\tCottonTail\tPeter");
		//System.out.println(bux);
	  	//R.addListEntry("http://spreadsheets.google.com/feeds/worksheets/ttXrIUcU402o2GV2jsGsF0g/private/full/od6", "year\t2009");
        //R.updateListEntry("http://spreadsheets.google.com/feeds/list/ttXrIUcU402o2GV2jsGsF0g/od6/private/full/cokwr", "year\t2031");
		//R.deleteListEntry("http://spreadsheets.google.com/feeds/list/ttXrIUcU402o2GV2jsGsF0g/od6/private/full/cokwr");
			
	  } catch (Exception ex){
	  	System.out.println(ex);
	  }
	  
	  System.out.println("Done!");
	}

}

//String aux = R.getDocsNames("");
//String aux = R.getDocumentNames("folder%3A7f42e3bd-a65f-486c-937d-a39a2c075458");
//String aux = R.getFolderNames();
//String bux = R.listAllWorksheets("te-a0B-G6X1dfZ0tD5AH9vA");
//String bux = R.readWorksheetListFeed("ttXrIUcU402o2GV2jsGsF0g", "Sheet 1");
//R.newWorksheet("mySheet", 100, 5, "ttXrIUcU402o2GV2jsGsF0g");
//String bux = R.getSpreadsheetDetails("te-a0B-G6X1dfZ0tD5AH9vA");