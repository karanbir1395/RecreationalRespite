using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Recreation_Respite_Dashboard.Models;

namespace Recreation_Respite_Dashboard.Controllers
{
    public class DiagnosesController : Controller
    {
        private DemoModelContainer db = new DemoModelContainer();

        // GET: Diagnoses
        public ActionResult Index()
        {
            return View(db.Diagnosis.ToList());
        }

        // GET: Diagnoses/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Diagnosis diagnosis = db.Diagnosis.Find(id);
            if (diagnosis == null)
            {
                return HttpNotFound();
            }
            return View(diagnosis);
        }

        // GET: Diagnoses/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Diagnoses/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,Name")] Diagnosis diagnosis)
        {
            if (ModelState.IsValid)
            {
                db.Diagnosis.Add(diagnosis);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(diagnosis);
        }

        // GET: Diagnoses/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Diagnosis diagnosis = db.Diagnosis.Find(id);
            if (diagnosis == null)
            {
                return HttpNotFound();
            }
            return View(diagnosis);
        }

        // POST: Diagnoses/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,Name")] Diagnosis diagnosis)
        {
            if (ModelState.IsValid)
            {
                db.Entry(diagnosis).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(diagnosis);
        }

        // GET: Diagnoses/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Diagnosis diagnosis = db.Diagnosis.Find(id);
            if (diagnosis == null)
            {
                return HttpNotFound();
            }
            return View(diagnosis);
        }

        // POST: Diagnoses/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Diagnosis diagnosis = db.Diagnosis.Find(id);
            db.Diagnosis.Remove(diagnosis);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
