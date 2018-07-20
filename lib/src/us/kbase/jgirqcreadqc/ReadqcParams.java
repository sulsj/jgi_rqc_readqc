
package us.kbase.jgirqcreadqc;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: readqcParams</p>
 * <pre>
 * Input for running readqc
 * fastqFile - fastq file upon which readqc will be run.
 * -OR-
 * fastaFile - local FASTA file upon which readqc will be run.
 * libName: input fastq/fasta's library name
 * isMultiplexed: set 1 if the input is a multiplexed fastq/fasta
 * </pre>
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "fastqFile",
    "fastaFile",
    "libName",
    "isMultiplexed"
})
public class ReadqcParams {

    @JsonProperty("fastqFile")
    private String fastqFile;
    /**
     * <p>Original spec-file type: fastaFileType</p>
     * <pre>
     * A local FASTA file.
     * path - the path to the FASTA file.
     * label - the label to use for the file in the readqc output. If missing, the file name will
     * be used.
     * </pre>
     * 
     */
    @JsonProperty("fastaFile")
    private FastaFileType fastaFile;
    @JsonProperty("libName")
    private String libName;
    @JsonProperty("isMultiplexed")
    private Long isMultiplexed;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("fastqFile")
    public String getFastqFile() {
        return fastqFile;
    }

    @JsonProperty("fastqFile")
    public void setFastqFile(String fastqFile) {
        this.fastqFile = fastqFile;
    }

    public ReadqcParams withFastqFile(String fastqFile) {
        this.fastqFile = fastqFile;
        return this;
    }

    /**
     * <p>Original spec-file type: fastaFileType</p>
     * <pre>
     * A local FASTA file.
     * path - the path to the FASTA file.
     * label - the label to use for the file in the readqc output. If missing, the file name will
     * be used.
     * </pre>
     * 
     */
    @JsonProperty("fastaFile")
    public FastaFileType getFastaFile() {
        return fastaFile;
    }

    /**
     * <p>Original spec-file type: fastaFileType</p>
     * <pre>
     * A local FASTA file.
     * path - the path to the FASTA file.
     * label - the label to use for the file in the readqc output. If missing, the file name will
     * be used.
     * </pre>
     * 
     */
    @JsonProperty("fastaFile")
    public void setFastaFile(FastaFileType fastaFile) {
        this.fastaFile = fastaFile;
    }

    public ReadqcParams withFastaFile(FastaFileType fastaFile) {
        this.fastaFile = fastaFile;
        return this;
    }

    @JsonProperty("libName")
    public String getLibName() {
        return libName;
    }

    @JsonProperty("libName")
    public void setLibName(String libName) {
        this.libName = libName;
    }

    public ReadqcParams withLibName(String libName) {
        this.libName = libName;
        return this;
    }

    @JsonProperty("isMultiplexed")
    public Long getIsMultiplexed() {
        return isMultiplexed;
    }

    @JsonProperty("isMultiplexed")
    public void setIsMultiplexed(Long isMultiplexed) {
        this.isMultiplexed = isMultiplexed;
    }

    public ReadqcParams withIsMultiplexed(Long isMultiplexed) {
        this.isMultiplexed = isMultiplexed;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((((((((("ReadqcParams"+" [fastqFile=")+ fastqFile)+", fastaFile=")+ fastaFile)+", libName=")+ libName)+", isMultiplexed=")+ isMultiplexed)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
