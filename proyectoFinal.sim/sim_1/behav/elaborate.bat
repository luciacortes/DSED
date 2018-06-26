@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 8f6451d359dd4af3bb837bb37472316a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot tb_FSMD_microphone_behav xil_defaultlib.tb_FSMD_microphone -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
