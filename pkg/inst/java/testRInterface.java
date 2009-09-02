
import dev.RInterface;


public class testRInterface {
	
	public static void main(String[] args){ 
		
	  RInterface R = new RInterface("R Docs Interface");
	  R.login("rdocsdemo@gmail.com", "RGooglePass12");
				
	  //String aux = R.getDocumentListEntries("folder"); // or "folder", "document", "presentation", "spreadsheet"
	  //String aux = R.fullTextQuery("virginica");
	  //System.out.println(aux);
  
	  //R.newDocument("test", "document");
	  //R.newDocument("dir1", "folder", "");
	  //R.newDocument("dir2", "folder", "folder%3A7f42e3bd-a65f-486c-937d-a39a2c075458");
	  //R.removeDocumentFromFolder("document%3Adft5h9w9_1dtc28pg3", "folder%3A7f42e3bd-a65f-486c-937d-a39a2c075458");
	  //R.trashDocument("document%3Adft5h9w9_0cq2vtgdf");
	  
	  
	  
	  R.uploadDocument("C:/Temp/RLicense.txt", "RLicense", "");
	  try{
	    //R.downloadDocument("spreadsheet%3Ate-a0B-G6X1dfZ0tD5AH9vA", "C:/Temp/Downloads/iris.xls", "4");
	  	//String bux = R.getWorksheetEntries("http://spreadsheets.google.com/feeds/spreadsheets/ttXrIUcU402o2GV2jsGsF0g");
	  	//R.addWorksheet("mySheet", 100, 5, "http://spreadsheets.google.com/feeds/spreadsheets/ttXrIUcU402o2GV2jsGsF0g");
	  	//R.deleteWorksheet("http://spreadsheets.google.com/feeds/worksheets/ttXrIUcU402o2GV2jsGsF0g/private/full/od4");	  	
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