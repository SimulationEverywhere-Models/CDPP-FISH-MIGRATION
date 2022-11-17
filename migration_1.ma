[top]
components : migration

[migration]
type : cell
width : 20
height : 20
delay : transport
defaultDelayTime : 10
border : nowrapped 
neighbors :                  migration(-1,0) 
neighbors :  migration(0,-1) migration(0,0)  migration(0,1)
neighbors :                  migration(1,0) 


initialvalue : 0

%from_v
%0:undefined, 1:up, 2:right, 3:down, 4:left
statevariables: path_v from_v number_v portion_v probability_v branch_v migrator_v display_v start_v initialize_v
statevalues: -1 0 0 0.8 0.9 1 0 0 0 0
initialvariablesvalue: migration_1.stvalues

neighborports: migrator_p from_p path_p

localtransition : migration-rule

[migration-rule]

rule : { ~path_p := $path_v; ~from_p := $from_v; ~migrator_p := $migrator_v; } { $start_v := 1; } 10 { $start_v = 0 }



%begin of initialize statevariables: branch_v, from_v


%entry : $branch_v = 0
%end : $branch_v = 0
$cell : 1 <= $branch_v <= 3
%base_rule : { 50 + $branch_v } { $branch_v := ( statecount(0, ~path_p) - 2 ); $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 2; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 5 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 2; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 4 and (-1,0)~path_p = -1 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 1; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 4 and (0,1)~path_p = -1 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 2; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 4 and (1,0)~path_p = -1 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 3; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and (-1,0)~path_p = -1 and (0,1)~path_p = -1 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 1; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and ( (1,0)~path_p = -1 or (1,0)~path_p = ? ) and ( (0,1)~path_p = -1 or (0,1)~path_p = ? ) }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 2; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and (1,0)~path_p = -1 and (0,-1)~path_p = -1 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 2; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and (-1,0)~path_p = -1 and (0,-1)~path_p = -1 }

rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 2; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and (-1,0)~path_p = -1 and (1,0)~path_p = -1 }

%undefined
%rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 1 or 3; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and (0,-1)~path_p = -1 and (0,1)~path_p = -1 }
rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 1; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and (0,-1)~path_p = -1 and (0,1)~path_p = -1 and ( (-1,0)~from_p = 1 or (-1,0)~from_p = 2 ) }
rule : { ~from_p := $from_v; } { $branch_v := ( statecount(0, ~path_p) - 2 ); $from_v := 3; $initialize_v := 1; } 10 { $initialize_v = 0 and $path_v = 0 and statecount(0,~path_p) = 3 and (0,-1)~path_p = -1 and (0,1)~path_p = -1 and ( (1,0)~from_p = 3 or (1,0)~from_p = 2 ) }

%end of initialize statevariables: branch_v, from_v


%begin of migration

%entry
rule : { ~migrator_p := $migrator_v; } { $display_v := 1; $number_v := $number_v - min( ( 1000 - 900 * power( abs( 5000 - time ), 2 ) / power(5000, 2) ), $number_v ); $migrator_v := min( ( 1000 - 900 * power( abs( 5000 - time ), 2 ) / power(5000, 2) ), $number_v ) * $probability_v; } 10 { $display_v = 0 and $path_v = 0 and statecount(0,~path_p) = 2 and ( (0,-1)~path_p = 0 or (1,0)~path_p = 0 ) and $number_v > 0 }
%end
rule : { ~migrator_p := $migrator_v; } { $display_v := 1; $number_v := $number_v + (-1,0)~migrator_p; $migrator_v := $number_v * $portion_v * $probability_v; $number_v := $number_v; } 10 { $display_v = 0 and $path_v = 0 and statecount(0,~path_p) = 2 and (-1,0)~path_p = 0 }
rule : { ~migrator_p := $migrator_v; } { $display_v := 1; $number_v := $number_v + (0,1)~migrator_p; $migrator_v := $number_v * $portion_v * $probability_v; $number_v := $number_v; } 10 { $display_v = 0 and $path_v = 0 and statecount(0,~path_p) = 2 and (0,1)~path_p = 0 }

rule : { ~migrator_p := $migrator_v; } { $display_v := 1; $number_v := $number_v + (-1,0)~migrator_p; $migrator_v := $number_v * $portion_v * $probability_v / $branch_v; $number_v := $number_v * (1 - $portion_v); } 10 { $display_v = 0 and $path_v = 0 and $from_v = 1 }

rule : { ~migrator_p := $migrator_v; } { $display_v := 1; $number_v := $number_v + (0,1)~migrator_p; $migrator_v := $number_v * $portion_v * $probability_v / $branch_v; $number_v := $number_v * (1 - $portion_v); } 10 { $display_v = 0 and $path_v = 0 and $from_v = 2 }

rule : { ~migrator_p := $migrator_v; } { $display_v := 1; $number_v := $number_v + (1,0)~migrator_p; $migrator_v := $number_v * $portion_v * $probability_v / $branch_v; $number_v := $number_v * (1 - $portion_v); } 10 { $display_v = 0 and $path_v = 0 and $from_v = 3 }


%end of migration




rule : { ~migrator_p := 1; ~from_p := max($number_v, 10); } { $display_v := 1; } 10 { $display_v = 0 and cellPos(0) = 0 and cellPos(1) = 18 }
rule : { ~migrator_p := 0; ~from_p := max($number_v, 10); } { $display_v := 0; } 10 { $display_v = 1 and cellPos(0) = 0 and cellPos(1) = 18 }

%rule : { ~migrator_p := 0; ~from_p := 0;  ~path_p := $path_v; } { $display_v := 0; } 10 { $display_v = 1 }
%rule : { $number_v + 100 } { $display_v := 0; } 10 { $display_v = 1 }
rule : { $number_v } { $display_v := 0; } 10 { $display_v = 1 }
%rule : { power( abs( 5000 - time ), 2 ) } { $display_v := 0; } 10 { $display_v = 1 }
%rule : { power(50, 2) } { $display_v := 0; } 10 { $display_v = 1 }

%rule : { time } 10 { $path_v = -1 }
%rule : { ~path_p := 0; ~from_p := 0; } 10 { $path_v = 0 }

%rule : { $number_v } { $display_v := 0; } 10 { $display_v = 1 }

%rule : { max($number_v, 10) } 10 { $path_v = -1 }
%rule : { $from_v + 20 } 10 { $path_v = 0 }

rule : { ~migrator_p := $migrator_v; ~from_p := $from_v; ~path_p := $path_v; } 10 { t }


