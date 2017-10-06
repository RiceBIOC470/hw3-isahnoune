function tophits = blasthits(accnumber,N)
    genbankinfo = getgenbank(accnumber);
    result = {};
    sequence = genbankinfo.Sequence;
    [requestID, requestTime] = blastncbi(sequence,'blastn','Database','refseq_rna');
    blastinfo = getblast(requestID,'WaitTime',requestTime);
    hits = blastinfo.Hits(1:N);
    for i = 1:N 
        hitsname = hits(i).Name;
        ref = strsplit(hitsname ,'|');
        result(1,i) = ref(4);
    end
    tophits = result;
end
