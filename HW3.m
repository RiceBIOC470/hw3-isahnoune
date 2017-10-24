% GB comments
1.	80 Submitted sketch should have a trace for the path alignment.   
2a. 70 Be careful with the use of the function showalignment. Feeding your align into the function only gives a snippet of the entire possible coding sequence and therefore outputs a artificially high percent alignment.
2b. 70 same issue as 2a. 
2c. 70 same issue as 2a
3a 100
3b. 100
3c. 100  	
Overall: 84


%HW3

%% Problem 1 - Smith-Waterman alignment
% Consider two sequences 'GTAATCC' and 'GTATCCG'

% Construct the scoring matrix for this with the parameters:
% match value = 2, mismatch value = -1, and gap penalty = -1. Use your
% solution to get the optimal alignment. If you prefer, it is acceptable to do this with
% pencil and paper, you can then take a snapshot of your solution and
% include it in your repository. 

%Optimal alignment:

%G T A A T C C -
%G T A - T C C G

%Score = 10
;

%% Problem 2 - using the NCBI databases and sequence alignments

% Erk proteins are critical signal transducers of MAP kinase signaling.
% Accessions numbers for ERK1 (also called MAPK3) and ERK2 (also called MAPK1) human mRNA are NM_002746 and
% NM_002745, respectively. 

% Part 1. Perform an alignment of the coding DNA sequences of ERK1 and
% ERK2. What fraction of base pairs in ERK1 can align to ERK2? 

ERK1 = getgenbank('NM_002746')
ERK2 = getgenbank('NM_002745')

idx = ERK1.CDS.indices;
ERK1CodingRegion = ERK1.Sequence(idx(1):idx(2));
idx = ERK2.CDS.indices;
ERK2CodingRegion = ERK2.Sequence(idx(1):idx(2));

[score, align, start]  = swalign (ERK1CodingRegion, ERK2CodingRegion, 'Alphabet', 'nt', 'Showscore', true);
showalignment(align);

%Identities = 811/1073 (76%)

% Part2. Perform an alignment of the aminoacid sequences of ERK1 and ERK2.
% What fraction of amino acids align?

ERK1TranslatedRegion = ERK1.CDS.translation;
ERK2TranslatedRegion = ERK2.CDS.translation;

[score, align, start] = swalign (ERK1.CDS.translation, ERK2.CDS.translation);
showalignment(align);

%Identities = 305/346 (88%)

% Part 3.  Use the NCBI tools to get mRNA sequences for the mouse genes ERK1 and
% ERK2 and align both the coding DNA sequences and protein sequences to the
% human versions. How similar are they?

MouseERK1 = getgenbank('AK155287')
MouseERK2 = getgenbank('AK035386')

idx2 = MouseERK1.CDS.indices;
MouseERK1CodingRegion = MouseERK1.Sequence(idx(1):idx(2));
idx2 = MouseERK2.CDS.indices;
MouseERK2CodingRegion = MouseERK2.Sequence(idx(1):idx(2));

[score, align, start]  = swalign (ERK1CodingRegion, MouseERK1CodingRegion);
showalignment(align);

%Identities = 781/865 (90%)

[score, align, start]  = swalign (ERK2CodingRegion, MouseERK2CodingRegion);
showalignment(align);

%Identities = 979/1056 (93%)

%% Problem 3: using blast tools programatically

% Part 1. Write a function that takes an NCBI accession number and a number N as input and
% returns a cell array of the accession numbers for the top N blast hits. 

tophits = blasthits(accnumber,N)

% Part 2. Write a function that takes an accession number as input, calls your function 
% from part 1, and returns two outputs - the closest scoring match in human DNA/RNA and the
% closest non-human match. Hint: see the "Source" or "SourceOrganism" field in the data
% returned by getgenbank. Make sure your function does something sensible
% if nothing human is found. 

[humanhit, organismhit] = comparison(accnumber)

%Accession number used: AF020038 = IDH1 gene in homo sapiens
%Humanhit = NM_001282386.1
%Organismhit = XM_012752111.2

% Part 3. Choose at least one gene from the human genome and one gene from
% another organism and run your code from part 2 on the relevant accession
% numbers. Comment on the results. 

[humanhit, organismhit] = comparison(accnumber)

%Accession number used: AB009903 = PTEN gene in homo sapiens
%Humanhit = NM_000314.6
%Organismhit = XM_014259492.1

%When analyzing the PTEN gene, the closest scoring match appears to be
%found in pseudopodoces humilis, which is commonly known as the ground tit,
%a bird found in the Himalayas. Not the closest scoring match I would have
%expected, but interesting nonetheless.

%Accession number used: AB108673.1 = SOX1 gene in the house mouse
%Humanhit = NM_003106
%Organismhit = XM_012928698.1

%When analyzing the SOX1 gene obtained from the house mouse, the closest
%scoring match is found in Ochotona princeps, which is the American pika,
%another form of rodent.
