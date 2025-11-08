@echo off

echo Generating Haxe externs from @nativescript/core...

REM Create externs directory if it doesn't exist
if not exist library\externs mkdir library\externs

REM Generate externs using dts2hx
call npx dts2hx @nativescript/core --namespace ns.externs --output library\externs\NativeScript.hx

REM Fix common issues in generated externs
echo Fixing generated externs...

REM Note: Windows doesn't have sed by default, so we'll skip auto-fixing
REM Users can manually edit or we provide a pre-generated extern file

echo Externs generation complete!
echo Generated files are in library\externs\
echo.
echo NOTE: If you see TypeScript errors, you may need to manually edit the generated file
echo or use the pre-generated externs included in the repository.

pause