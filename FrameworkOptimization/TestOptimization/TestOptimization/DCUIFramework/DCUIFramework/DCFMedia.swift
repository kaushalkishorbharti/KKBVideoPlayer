/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class DCFMedia: NSObject,NSCoding {
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: "id");
        aCoder.encode(fileType, forKey: "fileType")
        aCoder.encode(caption, forKey: "caption")
        aCoder.encode(fileUrl, forKey: "fileUrl")
        aCoder.encode(object, forKey: "object")


    }
    
    public required init?(coder aDecoder: NSCoder) {
        
//        if(self = self.init())
//        {
//          id = aDecoder.decodeObject(forKey: "id") as? Int
//        fileType = aDecoder.decodeObject(forKey: "fileType") as? String
//        caption = aDecoder.decodeObject(forKey: "caption") as? String
//          fileUrl = aDecoder.decodeObject(forKey: "fileUrl") as? String
//           object = aDecoder.decodeObject(forKey: "object") as? String
//         return self;
//        }

    }
    
	public var id : Int?
	public var fileType : String?
	public var caption : String?
	public var fileUrl : String?
    public var downloadableUrl: String?
    public var previewUrl : String?
    public var previewImage : UIImage?
    public var object : Any?
    public var duration: Int?
    public var width: Int?
    public var height: Int?

    public class func modelsFromDictionaryArray(array:NSArray) -> [DCFMedia]
    {
        var models:[DCFMedia] = []
        for item in array
        {
            models.append(DCFMedia(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    
    public class func getImageArray(mediaArray:Array<DCFMedia>)->Array<String>{
        
    
            
            var imageArray:Array<String> = []
            for media in mediaArray{
                
                if((media).fileType == "image"){
                    imageArray.append(media.fileUrl!);
                }
                else{
                    imageArray.append(media.previewUrl ?? "");
                }
                
            }
         return imageArray;
        
    }
    
    
    required public override init(){
        
    }

	required public init?(dictionary: NSDictionary) {

        
		id = dictionary["id"] as? Int
		fileType = dictionary["file_type"] as? String
		caption = dictionary["caption"] as? String
		fileUrl = dictionary["file_url"] as? String
        if dictionary["media_original_url"] as? String != nil{
        downloadableUrl = dictionary["media_original_url"] as? String
        }
        
        if dictionary["preview_url"] as? String != nil{
            previewUrl = dictionary["preview_url"] as? String
        }
        

	}
    
   

	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.fileType, forKey: "file_type")
		dictionary.setValue(self.caption, forKey: "caption")
		dictionary.setValue(self.fileUrl, forKey: "file_url")
        dictionary.setValue(self.downloadableUrl, forKey: "media_original_url");

		return dictionary
	}


}
