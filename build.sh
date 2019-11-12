#!/bin/sh

# build Android library
cd MaterialShowCaseView
gradle assembleRelease
cd ..

# copy libraries to the Xamarin project
cp MaterialShowCaseView/library/build/outputs/aar/library-2.1.0.aar MaterialShowcase.Xamarin.Android/Jars/library-2.1.0.aar

# build Xamarin Bindings
cd MaterialShowcase.Xamarin.Android
nuget restore
msbuild /t:Rebuild /p:Configuration=Release MaterialShowcase.Xamarin.Android.csproj
cd ..
mkdir -p _builds/materialShowCase
cp MaterialShowcase.Xamarin.Android/bin/Release/MaterialShowcase.Xamarin.Android*.dll _builds/materialShowCase/
mv MaterialShowcase.Xamarin.Android/bin/Release/MaterialShowcase.Xamarin.Android.*.nupkg MaterialShowcase.Xamarin.Android/bin/Release/MaterialShowcase.Xamarin.Android.nupkg
mkdir -p _builds/nugets
cp MaterialShowcase.Xamarin.Android/bin/Release/*.nupkg _builds/nugets
cp MaterialShowcase.Xamarin.Android/bin/Release/*.nuspec _builds/nugets
nuget push _builds/nugets/MaterialShowcase.Xamarin.Android.nupkg -Source https://api.nuget.org/v3/index.json