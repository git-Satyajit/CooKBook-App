//
//  AddReceipeViewModel.swift
//  CookBook
//
//  Created by Satyajit Bhol on 08/07/25.
//

import Foundation
import SwiftUI
@Observable
class AddReceipeViewModel {
      var receipeName = ""
      var preparationTime = 0
      var instruction = ""
      var showImageOption = false
      var showLibrary = false
      var displayReceipeImage: Image?
      var showCamera = false
}
