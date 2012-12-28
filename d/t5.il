uselib "user32.dll"
efunc MessageBoxA
efunc LoadCursorA
efunc RegisterClassExA
efunc CreateWindowExA
efunc ShowWindow
efunc UpdateWindow
efunc GetMessageA
efunc TranslateMessage
efunc DispatchMessageA
efunc PostQuitMessage
efunc DefWindowProcA

uselib "msvcrt.dll"
efunc _ltoa

uselib "kernel32.dll"
efunc ExitProcess
efunc GlobalAlloc
efunc GetModuleHandleA

uselib "gdi32.dll"
efunc GetStockObject


func()EntryPoint
	
	()define;
	()global;
	()main;
	
	(0)ExitProcess;
	(0)return;

func()define
	svar IDC_ARROW				$IDC_ARROW				0x00007F00=;
	svar WHITE_BRUSH			$WHITE_BRUSH			0x00000000=;
	svar CW_USEDEFAULT			$CW_USEDEFAULT			0x80000000=;
	svar WS_OVERLAPPEDWINDOW	$WS_OVERLAPPEDWINDOW	0x00CF0000=;
	svar WM_DESTROY				$WM_DESTROY				0x00000002=;
	svar SW_SHOWNORMAL			$SW_SHOWNORMAL			0x00000005=;
	
	svar NULL					$NULL					0=;
	
	(0)return;

func()global
	svar hInstance
	$hInstance		(0)GetModuleHandleA =; //インスタンスを取得する
	
	(0)return;

func()main
	
	var hWnd
	var msg
	array 12 wcex // ウィンドウクラス
	

	$wcex 0 + 48 =;									//cbSize
	$wcex 4 + 3							=;	// wc.style
	$wcex 8 + $WindowProc				=;	// wc.lpfnWndProc
	$wcex 12 + 0							=;	// wc.cbClsExtra
	$wcex 16 + 0							=;	// wc.cbWndExtra
	$wcex 20 + global::hInstance			=;	// wc.hInstance
	$wcex 24 + 0							=;	// wc.hIcon
	$wcex 28 + (IDC_ARROW 0)LoadCursorA	=;	// wc.hCursor
	$wcex 32 + 6 =;	// wc.hbrBackground
	$wcex 36 + 0							=;	// wc.lpszMenuName
	$wcex 40 + "aaa"						=;	// wc.lpszClassName
	$wcex 44 + 0						=;	// wc.lpszClassName
	
	($wcex)RegisterClassExA dialog;
	 // ウインドウクラス登録

	
	$hWnd
	(
		0
		global::hInstance
		0
		0
		480
		640
		0
		0
		WS_OVERLAPPEDWINDOW
		"title"
		"aaa"
		0
	)CreateWindowExA =;

	$hWnd dialog;
	WS_OVERLAPPEDWINDOW dialog;

	(SW_SHOWNORMAL hWnd )ShowWindow;		// ウインドウの表示
	(hWnd)UpdateWindow;				// ウインドウの最初の更新
	
	0 dialog;
	
	:WhileBegin_000	// メッセージループ
		((0 0 0 $msg)GetMessageA)gofalse:Break_000;
		
		($msg)TranslateMessage;
		($msg)DispatchMessageA;
		//0 dialog;
	goto:WhileBegin_000
	:Break_000
//	(0 "a" "bb" 0)MessageBoxA;
	(0)ExitProcess;
	(0)return;



// ウインドウプロシージャ

func (lparam wparam message hwnd)WindowProc
	

		(message WM_DESTROY == )gofalse:CaseEnd_000;
		
			(0)PostQuitMessage;
			
			goto:Break_001
		:CaseEnd_000
		
		(lparam wparam message hwnd)DefWindowProcA;
		
	:Break_001
	(0)return;

func (a)dialog
	var buf
	$buf (64 64)GlobalAlloc =;
	(10 buf a)_ltoa;
	(0 "dialog" buf 0)MessageBoxA;
	//(0)ExitProcess;
	(0)return;

