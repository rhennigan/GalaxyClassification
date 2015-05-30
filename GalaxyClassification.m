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

Unprotect["`*"]
ClearAll["`*"]

(* Exported symbols added here with SymbolName::usage *)

(* Begin Private Context *)
(*Begin["`Private`"]*)

(* Load dependencies *)
$ProjectDirectory = DirectoryName[$InputFileName];
getDependency[name_String] := Get[FileNameJoin[{$ProjectDirectory, name <> ".m"}]]
getDependency["ImageProcessing"];

(* Path configuration for importing images *)
$GalaxyImageSourceDirectory = FileNameJoin[{$ProjectDirectory, "images_training_rev1"}];
$GalaxyImageFilteredDirectory = FileNameJoin[{$ProjectDirectory, "images_training_rev1_filtered"}];

(* Get file names for images *)
sourceImageFileNames = FileNames[FileNameJoin[{$GalaxyImageSourceDirectory, "*.jpg"}]];
filteredImageFileNames = FileNames[FileNameJoin[{$GalaxyImageFilteredDirectory, "lg_*.jpg"}]];

If[Not[FileExistsQ[$GalaxyImageFilteredDirectory]],
  CreateDirectory[$GalaxyImageFilteredDirectory];
  
]



(* End Private Context *)
(*End[]*)

EndPackage[]