
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
 * <p>Original spec-file type: readqcAppParams</p>
 * <pre>
 * Input for running readqc as a Narrative application.
 * </pre>
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "workspaceName",
    "fastqFile",
    "libName",
    "isMultiplexed"
})
public class ReadqcAppParams {

    @JsonProperty("workspaceName")
    private String workspaceName;
    @JsonProperty("fastqFile")
    private String fastqFile;
    @JsonProperty("libName")
    private String libName;
    @JsonProperty("isMultiplexed")
    private Long isMultiplexed;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("workspaceName")
    public String getWorkspaceName() {
        return workspaceName;
    }

    @JsonProperty("workspaceName")
    public void setWorkspaceName(String workspaceName) {
        this.workspaceName = workspaceName;
    }

    public ReadqcAppParams withWorkspaceName(String workspaceName) {
        this.workspaceName = workspaceName;
        return this;
    }

    @JsonProperty("fastqFile")
    public String getFastqFile() {
        return fastqFile;
    }

    @JsonProperty("fastqFile")
    public void setFastqFile(String fastqFile) {
        this.fastqFile = fastqFile;
    }

    public ReadqcAppParams withFastqFile(String fastqFile) {
        this.fastqFile = fastqFile;
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

    public ReadqcAppParams withLibName(String libName) {
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

    public ReadqcAppParams withIsMultiplexed(Long isMultiplexed) {
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
        return ((((((((((("ReadqcAppParams"+" [workspaceName=")+ workspaceName)+", fastqFile=")+ fastqFile)+", libName=")+ libName)+", isMultiplexed=")+ isMultiplexed)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
