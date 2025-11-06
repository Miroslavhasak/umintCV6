clear; clc; close all;

u = (1.1*4+0.8*(4^3))/0.1; %  y = 4 y' = 0 y'' = 0
% y''+1.9*y'+1.1*y+0.8y^3=0.1*u

sim_name = ['cv6_sim'];
set_param(sim_name,'FastRestart','on');

tic
numgen=30;	% number of generations
lpop=30;	% number of chromosomes in population
lstring=3;	% number of genes in a chromosome
M=10000;    % maximum of the search space

Space=[zeros(1,lstring); ones(1,lstring)*M];
Delta=Space(2,:)/100;   
Pop=genrpop(lpop,Space);

% --- 1. FAZA: BEZ PENALIZACIE PREKMITU ---
Fit = ones(1,lpop)*10^20;
for gen=1:numgen
    evolution1(gen)=min(Fit);
    for j=1:lpop
        disp("Faza 1: "+gen+"/"+numgen+" jedinec "+ j)
        P = Pop(j,1);
        I = Pop(j,2);
        D = Pop(j,3);

        try
            out=sim(sim_name);
            Fit(j) = sum(abs(out.e.Data)); % IAE kriterium
        catch
            Fit(j) = 10e50;
        end
    end

    Best=selbest(Pop,Fit,[1 1]);
    Old=selrand(Pop,Fit,9);
    Work1 = selsus(Pop,Fit,10);
    Work2 = selsus(Pop,Fit,9);
    Work1=crossov(Work1,1,0);
    Work2=mutx(Work2,0.1,Space);
    Work2=muta(Work2,0.2,Delta,Space);
    Pop=[Best;Old;Work1;Work2];
end
P1 = Best(1,1); I1 = Best(1,2); D1 = Best(1,3);
out1=sim(sim_name);

% --- 2. FAZA: S PENALIZACIOU PREKMITU ---
Fit = ones(1,lpop)*10^20;
for gen=1:numgen
    evolution2(gen)=min(Fit);
    for j=1:lpop
        disp("Faza 2: "+gen+"/"+numgen+" jedinec "+ j)
        P = Pop(j,1);
        I = Pop(j,2);
        D = Pop(j,3);

        try
            out=sim(sim_name);
            Fit(j) = sum(abs(out.e.Data)); % IAE
            ymax = max(out.y.Data);
            wmax = max(out.w.Data);
            if ymax > 1.1 * wmax
                overshoot = ymax - 1.1 * wmax;
                Fit(j) = Fit(j) + 1e5 * overshoot; % penalizacia za preregulovanie
            end
        catch
            Fit(j) = 10e50;
        end
    end

    Best=selbest(Pop,Fit,[1 1]);
    Old=selrand(Pop,Fit,9);
    Work1 = selsus(Pop,Fit,10);
    Work2 = selsus(Pop,Fit,9);
    Work1=crossov(Work1,1,0);
    Work2=mutx(Work2,0.1,Space);
    Work2=muta(Work2,0.2,Delta,Space);
    Pop=[Best;Old;Work1;Work2];
end
P2 = Best(1,1); I2 = Best(1,2); D2 = Best(1,3);
out2=sim(sim_name);

toc

% --- GRAFY ---
figure;
plot(evolution1,'b');
title('Evolucia fitness bez penalizacie');
xlabel('Generacia'); ylabel('Fitness');

figure;
plot(out1.y.Time, out1.y.Data, 'b', out1.w.Time, out1.w.Data, 'r');
title('Regulovana a ziadana velicina (bez penalizacie)');
xlabel('cas'); ylabel('y, w'); legend('y','w');

figure;
plot(out1.u.Time, out1.u.Data, 'k');
title('Akcna velicina (bez penalizacie)');
xlabel('cas'); ylabel('u');

figure;
plot(evolution2,'b');
title('Evolucia fitness s penalizaciou prekmitu');
xlabel('Generacia'); ylabel('Fitness');

figure;
plot(out2.y.Time, out2.y.Data, 'b', out2.w.Time, out2.w.Data, 'r');
title('Regulovana a ziadana velicina (s penalizaciou)');
xlabel('cas'); ylabel('y, w'); legend('y','w');

figure;
plot(out2.u.Time, out2.u.Data, 'k');
title('Akcna velicina (s penalizaciou)');
xlabel('cas'); ylabel('u');

fprintf('\n--- Faza 1 (bez penalizacie) ---\n');
fprintf('P: %.4f I: %.4f D: %.4f \n',P1,I1,D1);
fprintf('--- Faza 2 (s penalizaciou) ---\n');
fprintf('P: %.4f I: %.4f D: %.4f \n',P2,I2,D2);

set_param(sim_name,'FastRestart','off');
