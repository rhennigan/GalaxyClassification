(* Mathematica Package         *)
(* Created by IntelliJ IDEA    *)

(* :Title: GalaxyClassification     *)
(* :Context: GalaxyClassification`  *)
(* :Author: rhennigan            *)
(* :Date: 5/30/2015              *)

(* :Package Version: 1.0       *)
(* :Mathematica Version:       *)
(* :Copyright: (c) 2015 rhennigan *)
(* :Keywords:                  *)
(* :Discussion:                *)

BeginPackage["GalaxyClassification`"]
(* Exported symbols added here with SymbolName::usage *)

(* Begin Private Context *)
(*Begin["`Private`"]*)

(* Path configuration for importing images *)
$GalaxyImageSourceDirectory = FileNameJoin[{NotebookDirectory[], "images_training_rev1"}];
$GalaxyImageFilteredDirectory = FileNameJoin[{NotebookDirectory[], "images_training_rev1_filtered"}];

(* Get file names for images *)
sourceImageFileNames = FileNames[FileNameJoin[{$GalaxyImageSourceDirectory, "*.jpg"}]];
filteredImageFileNames = FileNames[FileNameJoin[{$GalaxyImageFilteredDirectory, "lg_*.jpg"}]];

(* End Private Context *)
(*End[]*)

EndPackage[]