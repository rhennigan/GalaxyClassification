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

(* Load dependencies *)
$ProjectDirectory = DirectoryName[$InputFileName];
getDependency[name_String] := Get[FileNameJoin[{$ProjectDirectory, name <> ".m"}]]
getDependency["ImageProcessing"];

(* Exported symbols added here with SymbolName::usage *)

(* Begin Private Context *)
(*Begin["`Private`"]*)

(* Path configuration for importing images *)
$GalaxyImageSourceDirectory = FileNameJoin[{NotebookDirectory[], "images_training_rev1"}];
$GalaxyImageFilteredDirectory = FileNameJoin[{NotebookDirectory[], "images_training_rev1_filtered"}];

(* Get file names for images *)
sourceImageFileNames = FileNames[FileNameJoin[{$GalaxyImageSourceDirectory, "*.jpg"}]];
filteredImageFileNames = FileNames[FileNameJoin[{$GalaxyImageFilteredDirectory, "lg_*.jpg"}]];

If[Not[FileExistsQ[$GalaxyImageFilteredDirectory]],
  CreateDirectory[$GalaxyImageFilteredDirectory];

]



(* End Private Context *)
(*End[]*)

EndPackage[]