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

func()EntryPoint //ファイル先頭の関数から実行される。
	()define;
	()global;
	()main;
	
	(0)ExitProcess;
	(0)return;

func()define
	//プリプロセッサがないので
	//静的変数を作ってそこに代入します。
	svar IDC_ARROW				$IDC_ARROW				0x00007F00=;
	svar WHITE_BRUSH			$WHITE_BRUSH			0x00000000=;
	svar CW_USEDEFAULT			$CW_USEDEFAULT			0x80000000=;
	svar WS_OVERLAPPEDWINDOW	$WS_OVERLAPPEDWINDOW	0x00CF0000=;
	svar WM_DESTROY				$WM_DESTROY				0x00000002=;
	svar SW_SHOWNORMAL			$SW_SHOWNORMAL			0x00000001=;
	
	svar NULL					$NULL					0=;
	
	(0)return;

func()global
	svar hInstance
	$hInstance (0)GetModuleHandleA =; //インスタンスを取得する
	
	svar class
	$class "aaaa" =;
	
	(0)return;

func()main
	
	var hWnd
	array 6 msg
	array 12 wcex // ウィンドウクラス
	
	
	//構造体は大きいサイズの変数をつくり
	//ポインタを加算して代入する。
	$wcex 0 +48								=;	// wcex.cbSize
	$wcex 4 + 3								=;	// wcex.style
	
	//関数のポインタを構造体に代入
	$wcex 8 + $WindowProc					=;	// wcex.lpfnWndProc
	$wcex 12 + 0							=;	// wcex.cbClsExtra
	$wcex 16 + 0							=;	// wcex.cbWndExtra
	
	//静的変数は global::hInstance といった形式で
	//外部からアクセスすることが出来る。
	$wcex 20 + global::hInstance			=;	// wcex.hInstance
	$wcex 24 + 0							=;	// wcex.hIcon
	$wcex 28 + (IDC_ARROW 0)LoadCursorA		=;	// wcex.hCursor
	$wcex 32 + 6							=;	// wcex.hbrBackground
	$wcex 36 + 0							=;	// wcex.lpszMenuName
	$wcex 40 + global::class				=;	// wcex.lpszClassName
	$wcex 44 + 0							=;	// wcex.lpszClassName
	
	($wcex)RegisterClassExA;// ウインドウクラス登録

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
		
		// スコープ :: がなくても同じ名前の変数が
		// この関数内になければアクセスできる
		// 本来は define::WS_OVERLAPPEDWINDOW
		WS_OVERLAPPEDWINDOW
		"title"
		global::class
		0
	)CreateWindowExA =;

	(SW_SHOWNORMAL hWnd)ShowWindow;	// ウインドウの表示
	(hWnd)UpdateWindow;					// ウインドウの最初の更新

	// メッセージループ //
	:WhileBegin_000	
	((0 0 0 $msg)GetMessageA 0 >)gofalse:Break_000;
		
		($msg)TranslateMessage;
		($msg)DispatchMessageA;

	goto:WhileBegin_000
	:Break_000

	(0)ExitProcess;
	(0)return;

	
func (lparam wparam message hwnd)WindowProc

		(message WM_DESTROY == )gofalse:CaseEnd_000;
		//WM_DESTROYのとき
			(0)PostQuitMessage;
			
			goto:Break_001
		:CaseEnd_000
		
		//どの条件にも当てはまらなかったら
		((lparam wparam message hwnd)DefWindowProcA)return;
		
	:Break_001
	(0)return;
	
func (a)dialog
	var buf
	$buf (64 64)GlobalAlloc =;
	(16 buf a)_ltoa;
	(0 "dialog" buf 0)MessageBoxA;
	//(0)ExitProcess;
	(0)return;


