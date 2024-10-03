using Autodesk.AutoCAD.ApplicationServices.Core;
using Autodesk.AutoCAD.Runtime;
using System.IO;



namespace LayerExtractor
{
    public class ExtractorCommands
    {

        [CommandMethod("EXTRACTDATA")]
        public void ExtractData()
        {
            var doc = Application.DocumentManager.MdiActiveDocument;
            if (doc is null) return;
            var ed = doc.Editor;
            try
            {
                //extract layer names and save them to layers.txt
                var db = doc.Database;
                using (var writer = File.CreateText("layers.txt"))
                {
                    dynamic layers = db.LayerTableId;
                    foreach (dynamic layer in layers)
                        writer.WriteLine(layer.Name);
                }
            }
            catch (System.Exception e)
            {
                ed.WriteMessage("Error: {0}", e);
            }
        }
    }
}


