
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
 * <p>Original spec-file type: readqcOutput</p>
 * <pre>
 * Ouput of the run_readqc function.
 * shockId - the id of the shock node where the zipped readqc output is stored.
 * handle - the new handle for the shock node, if created.
 * nodeFileName - the name of the file stored in Shock.
 * size - the size of the file stored in shock.
 * readqcPath - the directory containing the readqc output and the zipfile of the directory.
 * </pre>
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "shockId",
    "handle",
    "nodeFileName",
    "size",
    "readqcPath"
})
public class ReadqcOutput {

    @JsonProperty("shockId")
    private String shockId;
    /**
     * <p>Original spec-file type: Handle</p>
     * <pre>
     * A handle for a file stored in Shock.
     * hid - the id of the handle in the Handle Service that references this shock node
     * id - the id for the shock node
     * url - the url of the shock server
     * type - the type of the handle. This should always be shock.
     * file_name - the name of the file
     * remote_md5 - the md5 digest of the file.
     * </pre>
     * 
     */
    @JsonProperty("handle")
    private Handle handle;
    @JsonProperty("nodeFileName")
    private String nodeFileName;
    @JsonProperty("size")
    private String size;
    @JsonProperty("readqcPath")
    private String readqcPath;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("shockId")
    public String getShockId() {
        return shockId;
    }

    @JsonProperty("shockId")
    public void setShockId(String shockId) {
        this.shockId = shockId;
    }

    public ReadqcOutput withShockId(String shockId) {
        this.shockId = shockId;
        return this;
    }

    /**
     * <p>Original spec-file type: Handle</p>
     * <pre>
     * A handle for a file stored in Shock.
     * hid - the id of the handle in the Handle Service that references this shock node
     * id - the id for the shock node
     * url - the url of the shock server
     * type - the type of the handle. This should always be shock.
     * file_name - the name of the file
     * remote_md5 - the md5 digest of the file.
     * </pre>
     * 
     */
    @JsonProperty("handle")
    public Handle getHandle() {
        return handle;
    }

    /**
     * <p>Original spec-file type: Handle</p>
     * <pre>
     * A handle for a file stored in Shock.
     * hid - the id of the handle in the Handle Service that references this shock node
     * id - the id for the shock node
     * url - the url of the shock server
     * type - the type of the handle. This should always be shock.
     * file_name - the name of the file
     * remote_md5 - the md5 digest of the file.
     * </pre>
     * 
     */
    @JsonProperty("handle")
    public void setHandle(Handle handle) {
        this.handle = handle;
    }

    public ReadqcOutput withHandle(Handle handle) {
        this.handle = handle;
        return this;
    }

    @JsonProperty("nodeFileName")
    public String getNodeFileName() {
        return nodeFileName;
    }

    @JsonProperty("nodeFileName")
    public void setNodeFileName(String nodeFileName) {
        this.nodeFileName = nodeFileName;
    }

    public ReadqcOutput withNodeFileName(String nodeFileName) {
        this.nodeFileName = nodeFileName;
        return this;
    }

    @JsonProperty("size")
    public String getSize() {
        return size;
    }

    @JsonProperty("size")
    public void setSize(String size) {
        this.size = size;
    }

    public ReadqcOutput withSize(String size) {
        this.size = size;
        return this;
    }

    @JsonProperty("readqcPath")
    public String getReadqcPath() {
        return readqcPath;
    }

    @JsonProperty("readqcPath")
    public void setReadqcPath(String readqcPath) {
        this.readqcPath = readqcPath;
    }

    public ReadqcOutput withReadqcPath(String readqcPath) {
        this.readqcPath = readqcPath;
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
        return ((((((((((((("ReadqcOutput"+" [shockId=")+ shockId)+", handle=")+ handle)+", nodeFileName=")+ nodeFileName)+", size=")+ size)+", readqcPath=")+ readqcPath)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
