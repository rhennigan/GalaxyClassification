(* Mathematica source file  *)
(* Created by IntelliJ IDEA *)
(* :Author: rhennigan *)
(* :Date: 5/30/2015 *)

BeginPackage["GalaxyClassification`ImageProcessing`", {"GalaxyClassification`"}]

CheckAndTransform::usage = ""

Begin["`Private`"]

selectGalaxy[img_, t_] := SelectComponents[FillingTransform@Binarize[img, t], "Area", -1]
selectGalaxy[img_] := SelectComponents[FillingTransform@Binarize[img], "Area", -1]
galaxyAngle[galaxyComponent_] := 1 /. ComponentMeasurements[galaxyComponent, "Orientation"]
croppedCentroid[img_, s_] := ImageMeasurements[ImageCrop[img, s], "IntensityCentroid"] / s
contrast[img_, exponent_] := ImageApply[Max[0.0, #]^exponent&, img]

selectCenterGalaxy[img_, t_] := Module[
  {components, label},
  components = FillingTransform@Binarize[img, t];
  label = MinimalBy[ComponentMeasurements[components, "Centroid"], Norm[#[[2]] - ImageDimensions[img] / 2]&][[1, 1]];
  SelectComponents[components, "Label", # == label&]
]
selectCenterGalaxy[img_] := Module[
  {components, label},
  components = FillingTransform@Binarize[img];
  label = MinimalBy[ComponentMeasurements[components, "Centroid"], Norm[#[[2]] - ImageDimensions[img] / 2]&][[1, 1]];
  SelectComponents[components, "Label", # == label&]
]

transformImage[img_] := Module[{w, h, components, label, img2, imgc, orientation, rotated, cropped, resized},
  {w, h} = ImageDimensions[img];
  components = DeleteSmallComponents[FillingTransform@Dilation[AlphaChannel[RemoveBackground[img, {{{1, 1}, {w, 1}, {1, h}, {w, h}}, .025}]], 2]];
  label = MinimalBy[ComponentMeasurements[components, "Centroid"], Norm[#[[2]] - ImageDimensions[img] / 2]&][[1, 1]];
  img2 = ImageMultiply[img, Blur[SelectComponents[components, "Label", # == label&], 8]];
  imgc = ImageCrop[img2, {w, h}];
  orientation = galaxyAngle[selectGalaxy[imgc]];
  rotated = ImageCrop[ImageRotate[imgc, -orientation], Min[w, h] / 2];
  cropped = ImageTrim[rotated, {{-20, -20}, {20, 20}} + Round[1 /. ComponentMeasurements[selectCenterGalaxy[rotated, .05], "BoundingBox"]]];
  resized = With[{m = Max[ImageDimensions[cropped]]}, ImageResize[ImageCrop[cropped, {m, m}], Min[w, h] / 2]];
  resized
]

CheckAndTransform[outDir_String, fileName_String] := Module[
  {outFileName},
  outFileName = FileNameJoin[{outDir, FileNameTake[fileName]}];
  If[Not[FileExistsQ[outFileName]], Export[outFileName, transformImage[Import[fileName]]]];
]

(* End Private Context *)
End[]

EndPackage[]