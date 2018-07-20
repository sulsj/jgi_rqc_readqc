
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
 * <p>Original spec-file type: readqcAppOutput</p>
 * <pre>
 * Output of the run_readqc_app function.
 * </pre>
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "reportName",
    "reportRef"
})
public class ReadqcAppOutput {

    @JsonProperty("reportName")
    private String reportName;
    @JsonProperty("reportRef")
    private String reportRef;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("reportName")
    public String getReportName() {
        return reportName;
    }

    @JsonProperty("reportName")
    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public ReadqcAppOutput withReportName(String reportName) {
        this.reportName = reportName;
        return this;
    }

    @JsonProperty("reportRef")
    public String getReportRef() {
        return reportRef;
    }

    @JsonProperty("reportRef")
    public void setReportRef(String reportRef) {
        this.reportRef = reportRef;
    }

    public ReadqcAppOutput withReportRef(String reportRef) {
        this.reportRef = reportRef;
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
        return ((((((("ReadqcAppOutput"+" [reportName=")+ reportName)+", reportRef=")+ reportRef)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
