uselib "user32.dll"
efunc MessageBoxA

uselib "msvcrt.dll"
efunc _ltoa

uselib "kernel32.dll"
efunc ExitProcess
efunc GlobalAlloc

func()EntryPoint //ファイル先頭の関数から実行される。
	
	var a
	var buffer

	//メモリを確保してそのポインタを
	//bufferに代入する
	$buffer (64 0x40)GlobalAlloc = ;

	
	//階乗を計算して、その答えをaに代入
	$a (10)f = ;

	//数値を文字列に変換してbufferに格納する
	(10 buffer a)_ltoa;

	//答えを表示
	(0 "Title" buffer 0)MessageBoxA;
	
	(0)ExitProcess;
	(0)return;

func (a)f

	(a 1 <=)gotrue:zz;
		( a (a 1 -)f * )return;
	:zz
	(1)return;


