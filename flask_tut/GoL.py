from flask import Flask, render_template, url_for
from flask import request

#---------- URLS AND WEB PAGES -------------#

# Initialize the app
app = Flask(__name__)

# Homepage
@app.route("/")
def viz_page():
    """
    Homepage: serve up the .pde in the homepage
    """
    return render_template("index.html")

#--------- RUN WEB APP SERVER ------------#

if __name__ == "__main__":
    app.run(debug=True)