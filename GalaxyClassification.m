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
Needs["TypeSystem`"];

$ProjectDirectory = DirectoryName[$InputFileName];
getDependency[name_String] := Get[FileNameJoin[{$ProjectDirectory, name <> ".m"}]]
getDependency["ImageProcessing"];

Needs["GalaxyClassification`ImageProcessing`"];

(* Path configuration for importing images *)
$GalaxyImageSourceDirectory = FileNameJoin[{$ProjectDirectory, "images_training_rev1"}];
$GalaxyImageFilteredDirectory = FileNameJoin[{$ProjectDirectory, "images_training_rev1_filtered"}];

(* Get file names for images *)
If[Not[FileExistsQ[$GalaxyImageFilteredDirectory]], CreateDirectory[$GalaxyImageFilteredDirectory]];
sourceImageFileNames = FileNames[FileNameJoin[{$GalaxyImageSourceDirectory, "*.jpg"}]];
filteredImageFileNames = FileNames[FileNameJoin[{$GalaxyImageFilteredDirectory, "*.jpg"}]];

ParallelDo[CheckAndTransform[$GalaxyImageFilteredDirectory, fileName], {fileName, sourceImageFileNames}];

$TrainingDataByID = Module[
  {import, variableNames, data, invCDF, makeClassAssociation, dataType},
  import = Import[FileNameJoin[{$ProjectDirectory, "training_solutions_rev1.csv"}]];
  variableNames = StringReplace[#, {"Class" -> "C", "." -> "S"}]& /@ First[import];
  data = Rest[import];
  (*invCDF = Function[x, -Sqrt[2] InverseErfc[2 (x + $MachineEpsilon - 2 x $MachineEpsilon)]];*)
  invCDF = Function[x, Log[-1 - 1 / (-1 + x + $MachineEpsilon - 2 x $MachineEpsilon)]];
  makeClassAssociation = Function[row, Module[
    {association = Association[Thread[Rest[variableNames] -> invCDF /@ N[Rest[row]]]]},
    Prepend[association, First[variableNames] -> First[row]]
  ]];
  dataType = TypeSystem`Vector[
    TypeSystem`Struct[variableNames,
      Prepend[Table[TypeSystem`Atom[Real], {Length[variableNames] - 1}], TypeSystem`Atom[Integer]]
    ], Length[data]
  ];
  Dataset[ParallelMap[makeClassAssociation, data], dataType]
];

(* End Private Context *)
(*End[]*)

EndPackage[]