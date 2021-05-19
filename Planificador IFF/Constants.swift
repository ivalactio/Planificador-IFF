//
//  Constants.swift
//  Planificador IFF
//
//  Created by ivan on 17/05/2021.
//

import Foundation


class Constantes {
    struct constants{
        static var minPrevios = 60
        

        
    }
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}


