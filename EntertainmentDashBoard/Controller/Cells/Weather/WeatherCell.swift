//
//  WeatherCell.swift
//  EntertainmentDashBoard
//
//  Created by Eric on 1/10/19.
//  Copyright © 2019 Eric. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    let convert = utilities()
    
    @IBOutlet weak var weatherBKG: UIImageView!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var switchDegree: UISwitch!
    
    let weatherViewModel = WeatherViewModel()
    
    var context = CIContext(options: nil)
    
    override func awakeFromNib() {
        getWeatherData()
        self.backgroundColor = globalColor.cellBackground
    }
    
    func getWeatherData(){
        weatherViewModel.getCurrentWeather(){[weak self] success in
            DispatchQueue.main.async {
                if success{
                    self!.populate(model: (self!.weatherViewModel.model)!)
                }
            }
        }
    }
    
    func populate(model:WeatherModel){
        setWeatherImage(imgURL: model.imageUrl)

        labelTemp.text = String(Int(model.temp))
        labelWeather.text = model.cityName
        labelDesc.text = model.desc
    }
    
    func setWeatherImage(imgURL:String){
        let _url = URL(string: imgURL)
        imgWeather!.sd_setImage(with: _url,
                               placeholderImage: defaultMovieImage,
                               options: .continueInBackground)
    }
    
    
    
    func blurEffect() {
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: weatherBKG.image!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        weatherBKG.image = processedImage
    }
   
}
