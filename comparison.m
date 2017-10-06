function [humanhit, organismhit] = comparison(accnumber)
    tophits = blasthits(accnumber,50);
    human = ''
    organism = ''
 
    for i = 2:50
        geneinfo = getgenbank(char(tophits(1,i)));
        if contains(geneinfo.Source, 'homo sapiens','IgnoreCase',true) 
            human = char(tophits(1,i));
        elseif ~contains(geneinfo.Source, 'homo sapiens', 'IgnoreCase', true)
            organism = char(tophits(1,i));  
        end
    end
    humanhit = human
    organismhit = organism
    
end