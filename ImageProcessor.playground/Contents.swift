//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")

class ColorFilter{
    var rgba = [UInt8](count:5, repeatedValue: 0)
}

let redFilter: ColorFilter = ColorFilter()
let greenFilter: ColorFilter = ColorFilter()
let blueFilter: ColorFilter = ColorFilter()
let alphaFilter: ColorFilter = ColorFilter()

redFilter.rgba[0] = 255
greenFilter.rgba[1] = 255
blueFilter.rgba[2] = 255
alphaFilter.rgba[3] = 70


class ImageProcessor{
    var filtersList: [String] = []
    var filtersAvailable: [String: ColorFilter] = [
        "redFilter": redFilter,
        "greenFilter": greenFilter,
        "blueFilter": blueFilter,
        "alphaFilter": alphaFilter,
    ]
    func addFilter(filterName: String){
        filtersList.append(filterName)
    }
    func appyFilters(image: UIImage) -> UIImage{
        var filters: [ColorFilter] = []
        for name in filtersList{
            filters.append(filtersAvailable[name]!)
        }
        let rgbaImage = RGBAImage(image: image)!
        for y in 0..<rgbaImage.height{
            for x in 0..<rgbaImage.width{
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                for filter in filters{
                    for value in 0...4 {
                        if(filter.rgba[value] != 0 ){
                            switch value{
                            case 0:
                                pixel.red = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel 
                            case 1:
                                pixel.green = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel
                            case 2:
                                pixel.blue = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel
                            case 3:
                                pixel.alpha = filter.rgba[value]
                                rgbaImage.pixels[index] = pixel
                            default:
                                print("Yo!")
                                
                            }
                        }
                    }
                }
            }
        }
        let newImage = rgbaImage.toUIImage()!
        return newImage
    }
}

var processor: ImageProcessor = ImageProcessor()

processor.addFilter("alphaFilter")
processor.addFilter("redFilter")
//processor.addFilter("greenFilter")
//processor.addFilter("blueFilter")

processor.appyFilters(image!)

